import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab_kitab/Utils/widgets.dart';
import '../../controllers/SignupController.dart';
class SignupScreen extends GetWidget<SignupController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [

              Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /*SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showImageSelectOption(
                      context: context,
                      completionHandler: (img){
                        controller.imageFile.value = img;
                      }
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(
                         () {
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                            controller.imageFile.value != null ? FileImage(controller.imageFile.value!) : null,
                            child: controller.imageFile.value == null
                                ? Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey[700],
                            )
                                : null,
                          );
                        }
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: Icon(Icons.edit, size: 18, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),*/
              SizedBox(height: 24),
              TextField(
                textInputAction: TextInputAction.next,
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),  TextField(
                textInputAction: TextInputAction.next,
                controller: controller.userNameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedFamilyStatus.value.isEmpty
                    ? null
                    : controller.selectedFamilyStatus.value,
                items: controller.familyOptions
                    .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedFamilyStatus.value = value;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Family Status',
                  border: OutlineInputBorder(),
                ),
              )),
              SizedBox(height: 16),
              Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: controller.togglePasswordVisibility,
                  ),

                ),

                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(controller.cPassFocus.value);
                },
              )),
              SizedBox(height: 16),
              Obx(() => TextField(
                controller: controller.confirmPasswordController,
                obscureText: controller.isConfirmPasswordHidden.value,
                focusNode: controller.cPassFocus.value,
              textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',

                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isConfirmPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
              )),
              SizedBox(height: 24),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.signup,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
