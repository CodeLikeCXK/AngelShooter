class AAngelCharacterControllerBase : APlayerController
{
  UPROPERTY(Category = "Input")
  UInputAction Action;

  UPROPERTY(Category = "Input")
  UInputMappingContext Context;

  UEnhancedInputComponent InputComponent;

  UFUNCTION(BlueprintOverride)
  void BeginPlay()
  {
    InputComponent = UEnhancedInputComponent::Get(this);

    PushInputComponent(InputComponent);

    UEnhancedInputLocalPlayerSubsystem EnhancedInputSubsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
    EnhancedInputSubsystem.AddMappingContext(Context, 0, FModifyContextOptions());

    InputComponent.BindAction(Action, ETriggerEvent::Triggered, this, n"Input_Action");
  }

  // Depending on the Input action, the type of ActionValue
  // may change (i.e. bool, Vector2D, float, etc)
  UFUNCTION()
  void Input_Action(float ActionValue, float32 ElapsedTime, float32 TriggeredTime, UInputAction SourceAction)
  {
    Print("Hello world");
  }
}