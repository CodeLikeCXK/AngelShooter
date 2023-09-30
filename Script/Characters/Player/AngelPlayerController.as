class AAngelPlayerControllerBase : APlayerController
{

  default bReplicates = true;

  UPROPERTY(EditAnywhere, Category = "Input")
  UInputAction MoveAction;

  UPROPERTY(EditAnywhere, Category = "Input")
  UInputMappingContext Context;

  UPROPERTY(DefaultComponent)
  UEnhancedInputComponent InputComponent;

  USpringArmComponent PlayerCameraBoom;



  UFUNCTION(BlueprintOverride)
  void BeginPlay()
  {
      //setup input   
      SetupInputComponent();
      PlayerCameraBoom = Cast<USpringArmComponent>(ControlledPawn.GetComponentByClass(USpringArmComponent::StaticClass()));
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

//
 UFUNCTION()
void Move(const FInputActionValue& InputActionValue,float32 ElapsedTime,float32 TriggeredTime,UInputAction SourceAction)
  {
    FVector2D MovementVector = InputActionValue.GetAxis2D();
    const FRotator Rotation = GetControlRotation();
    const FRotator YawRotationForward(PlayerCameraBoom.RelativeRotation.Pitch, PlayerCameraBoom.RelativeRotation.Yaw, 0);
    const FRotator YawRotationRight(0, PlayerCameraBoom.RelativeRotation.Yaw, 0);

    const FVector ForwardDirection = YawRotationForward.ForwardVector;
    const FVector RightdDirection = YawRotationRight.RightVector;

    ControlledPawn.AddMovementInput(ForwardDirection, MovementVector.Y);
    ControlledPawn.AddMovementInput(RightdDirection, MovementVector.X);
  }






}
