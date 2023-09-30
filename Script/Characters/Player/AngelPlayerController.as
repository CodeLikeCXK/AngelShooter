class AAngelPlayerControllerBase : APlayerController
{

  default bReplicates = true;

  UPROPERTY(EditAnywhere, Category = "Input")
  UInputAction MoveAction;

  UPROPERTY(EditAnywhere, Category = "Input")
  UInputMappingContext Context;

  UPROPERTY(DefaultComponent)
  UEnhancedInputComponent InputComponent;



  UFUNCTION(BlueprintOverride)
  void BeginPlay()
  {
      //setup input   
      SetupInputComponent();
  }

  UFUNCTION()
  void SetupInputComponent()
  {
    //setup input action    
    InputComponent = UEnhancedInputComponent::Get(this);
    PushInputComponent(InputComponent);
    UEnhancedInputLocalPlayerSubsystem Subsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
    Subsystem.AddMappingContext(Context,0, FModifyContextOptions());
    bShowMouseCursor = true;
    EMouseCursor DefaultMouseCursor = EMouseCursor::Default;  

    //setup input action    
    InputComponent.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this,n"Move"));

  }

//enhanced input method not ready for 5.11
//
 UFUNCTION()
void Move(const FInputActionValue& InputActionValue,float32 ElapsedTime,float32 TriggeredTime,UInputAction SourceAction)
  {
    //const FVector2D InputAxisVector = Math::RoundToFloat(InputActionValue);
    //const FRotator Rotation = GetControlRotation();
    //const FRotator YawRotation(0.f, Rotation.Yaw, 0.f);

    //const FVector ForwardDirection = ControlRotation.ForwardVector;
    //const FVector RightdDirection = ControlRotation.RightVector;

    //ControlledPawn.AddMovementInput(ForwardDirection, InputAxisVector.Y);
    //ControlledPawn.AddMovementInput(RightdDirection, InputAxisVector.X);
  }






}
