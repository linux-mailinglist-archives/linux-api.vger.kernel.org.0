Return-Path: <linux-api+bounces-6065-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPDwG3gG1GnUpwcAu9opvQ
	(envelope-from <linux-api+bounces-6065-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 21:16:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DED3A690D
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653CB302D100
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B2390980;
	Mon,  6 Apr 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="YMMAcelD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-m60129.netease.com (mail-m60129.netease.com [210.79.60.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9C396D2E;
	Mon,  6 Apr 2026 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502863; cv=none; b=ualTWTSzsM2NeeC8eB6haAhA6YBOQK65zTXnf+ZFTn/aEfY/3zl1KykhJG0gKjAaKQIF7XH8pS2mUee5fPOImQOGZbNqaUqS8mpzmwosoz/HuKEfyygbEBJyet5zy6EPe3jBXUkhCwix27BRCCP8FKMb2w6XUlRa86xWV7MnIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502863; c=relaxed/simple;
	bh=ECGDkkNunsT7ol5JdVMZSZKKWi2mfnpcNCd1+Vi8iIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7bLKAyxtBjhdgCmw74vxS203O3afo7ukSLoe3ctF3qKUsoyTSNip2tbeEKASIimwgtmFVnoKyxZzqvDnnmI5CmrBMy4A8SqGv6P8adobtBctyo1Jj94giCKgdtEhqe7lbGA3NXkSsctrNaMJVLgnpWk3oRsTsVpybmLfteE3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=YMMAcelD; arc=none smtp.client-ip=210.79.60.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39aaefbdf;
	Tue, 7 Apr 2026 00:51:42 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: ojeda@kernel.org,
	dakr@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [RFC PATCH v3 5/6] rust: miscdevice: harden registration and safe file_operations invariants
Date: Mon,  6 Apr 2026 12:51:19 -0400
Message-Id: <20260406165120.166928-6-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406165120.166928-1-wenzhaoliao@ruc.edu.cn>
References: <cover.1775456181.git.wenzhaoliao@ruc.edu.cn>
 <20260406165120.166928-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d63b50c3403a2kunm562d3b0d647e8b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTElDVk1CHh9ITx5NS04dSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YMMAcelD5EoMn8NHp9n6qlxUOGKmMtUALBcVlOR799f6xXzFfv810WTv5EMVb/Afq0/YTUqVWRyhicvH0q6gU7aTwqXi3w2q2j5+otxhCSYTae2KW0WjqjYxig3FbwohbLIkTom03/0BKIDZT6EMG9iCT2DjBst+9RjUKxgFfgA=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=83Aos2kKrx0e0kDnA4rTmWci8dP3/t1joOgL0B9Gz+g=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6065-lists,linux-api=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,result.name:url,self.data:url,open_file.data:url]
X-Rspamd-Queue-Id: C1DED3A690D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend miscdevice registration with typed per-device data that open()
can read through a publication-safe context, and move raw
file_operations exposure behind an internal vtable boundary generated by
declare_misc_device_fops!().

This keeps safe open() on pre-publication state, binds
file_operations.owner to THIS_MODULE for safe drivers, and keeps the
private_data ownership protocol inside the abstraction instead of in
driver code. The goldfish driver uses the typed registration data to
pass its runtime into open() without raw casts or container traversal.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/miscdevice.rs        | 409 +++++++++++++++++++++++--------
 samples/rust/rust_misc_device.rs |   9 +-
 2 files changed, 306 insertions(+), 112 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index c3c2052c9206..c2db81cd5da2 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -9,7 +9,8 @@
 //! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
 
 use crate::{
-    bindings,
+    alloc::KBox,
+    bindings, container_of,
     device::Device,
     error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_int, c_long, c_uint, c_ulong},
@@ -18,9 +19,15 @@
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
-    types::{ForeignOwnable, Opaque},
+    sync::aref::ARef,
+    types::{ForeignOwnable, Opaque, ScopeGuard},
+};
+use core::{
+    marker::{PhantomData, PhantomPinned},
+    pin::Pin,
+    ptr::drop_in_place,
+    sync::atomic::{AtomicBool, Ordering},
 };
-use core::{marker::PhantomData, pin::Pin};
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]
@@ -31,94 +38,258 @@ pub struct MiscDeviceOptions {
 
 impl MiscDeviceOptions {
     /// Create a raw `struct miscdev` ready for registration.
-    pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
+    pub fn into_raw<T: MiscDeviceVTable + 'static>(self) -> bindings::miscdevice {
         let mut result: bindings::miscdevice = pin_init::zeroed();
         result.minor = bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
         result.name = crate::str::as_char_ptr_in_const_context(self.name);
-        result.fops = MiscdeviceVTable::<T>::build();
+        result.fops = T::file_operations();
         result
     }
 }
 
+/// Generates the `MiscDeviceVTable` implementation for a concrete miscdevice type.
+///
+/// Place this macro after `impl MiscDevice for ...`.
+///
+/// The generated implementation always binds `file_operations.owner` to the current module's
+/// `THIS_MODULE`, so safe drivers cannot accidentally publish owner-less or foreign-owned misc
+/// device callbacks.
+#[macro_export]
+macro_rules! declare_misc_device_fops {
+    ($type:ty) => {
+        // SAFETY: This implements the standard Rust miscdevice vtable generated by
+        // `build_file_operations()`, which wires up owner/module pinning and the private-data
+        // protocol enforced by this abstraction.
+        unsafe impl $crate::miscdevice::MiscDeviceVTable for $type {
+            fn file_operations() -> &'static $crate::bindings::file_operations {
+                struct AssertSync<T>(T);
+                // SAFETY: This wrapper is only used for immutable `file_operations` tables stored
+                // in a `static`.
+                unsafe impl<T> Sync for AssertSync<T> {}
+
+                static FOPS: AssertSync<$crate::bindings::file_operations> = AssertSync(
+                    $crate::miscdevice::build_file_operations::<$type>(THIS_MODULE.as_ptr()),
+                );
+
+                &FOPS.0
+            }
+        }
+    };
+}
+
+#[repr(C)]
+struct RegistrationBacking<T: MiscDevice + 'static> {
+    misc: Opaque<bindings::miscdevice>,
+    data: T::RegistrationData,
+    owner: *const MiscDeviceRegistration<T>,
+    registered: AtomicBool,
+}
+
+struct OpenFile<T: MiscDevice + 'static> {
+    data: *mut ffi::c_void,
+    _t: PhantomData<T>,
+}
+
+impl<T: MiscDevice + 'static> OpenFile<T> {
+    fn empty() -> Self {
+        Self {
+            data: core::ptr::null_mut(),
+            _t: PhantomData,
+        }
+    }
+
+    fn borrow(&self) -> <T::Ptr as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: `self.data` comes from `T::Ptr::into_foreign()` and is only converted back in
+        // `release`, after all borrows from this file operation callback have ended.
+        unsafe { <T::Ptr as ForeignOwnable>::borrow(self.data) }
+    }
+}
+
 /// A registration of a miscdevice.
 ///
 /// # Invariants
 ///
-/// - `inner` contains a `struct miscdevice` that is registered using
-///   `misc_register()`.
-/// - This registration remains valid for the entire lifetime of the
-///   [`MiscDeviceRegistration`] instance.
-/// - Deregistration occurs exactly once in [`Drop`] via `misc_deregister()`.
-/// - `inner` wraps a valid, pinned `miscdevice` created using
+/// - `backing.misc` contains a valid `struct miscdevice` created using
 ///   [`MiscDeviceOptions::into_raw`].
-#[repr(transparent)]
+/// - When `backing.registered` is `true`, `backing.misc` is registered using
+///   `misc_register()`.
+/// - Before `misc_register()` publishes `backing.misc`, every field reachable through the safe
+///   open context (`backing.data` and `backing.owner`) is fully initialized.
+/// - `backing.owner` points back to this wrapper for the entire time the miscdevice is registered.
+/// - Deregistration occurs at most once, either via [`MiscDeviceRegistration::deregister`] or
+///   [`Drop`].
 #[pin_data(PinnedDrop)]
-pub struct MiscDeviceRegistration<T> {
+pub struct MiscDeviceRegistration<T: MiscDevice + 'static> {
+    backing: KBox<RegistrationBacking<T>>,
     #[pin]
-    inner: Opaque<bindings::miscdevice>,
+    _pin: PhantomPinned,
     _t: PhantomData<T>,
 }
 
 // SAFETY: It is allowed to call `misc_deregister` on a different thread from where you called
 // `misc_register`.
-unsafe impl<T> Send for MiscDeviceRegistration<T> {}
+unsafe impl<T: MiscDevice> Send for MiscDeviceRegistration<T> {}
 // SAFETY: All `&self` methods on this type are written to ensure that it is safe to call them in
 // parallel.
-unsafe impl<T> Sync for MiscDeviceRegistration<T> {}
+unsafe impl<T: MiscDevice> Sync for MiscDeviceRegistration<T> {}
 
-impl<T: MiscDevice> MiscDeviceRegistration<T> {
+impl<T: MiscDevice + 'static> MiscDeviceRegistration<T> {
     /// Register a misc device.
-    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
-        try_pin_init!(Self {
-            inner <- Opaque::try_ffi_init(move |slot: *mut bindings::miscdevice| {
-                // SAFETY: The initializer can write to the provided `slot`.
-                unsafe { slot.write(opts.into_raw::<T>()) };
-
-                // SAFETY: We just wrote the misc device options to the slot. The miscdevice will
-                // get unregistered before `slot` is deallocated because the memory is pinned and
-                // the destructor of this type deallocates the memory.
-                // INVARIANT: If this returns `Ok(())`, then the `slot` will contain a registered
-                // misc device.
-                to_result(unsafe { bindings::misc_register(slot) })
-            }),
-            _t: PhantomData,
-        })
+    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error>
+    where
+        T: MiscDevice<RegistrationData = ()> + MiscDeviceVTable,
+    {
+        Self::register_with_data(opts, ())
+    }
+
+    /// Register a misc device together with driver-defined registration data.
+    pub fn register_with_data(
+        opts: MiscDeviceOptions,
+        data: T::RegistrationData,
+    ) -> impl PinInit<Self, Error>
+    where
+        T: MiscDeviceVTable,
+    {
+        let init = move |slot: *mut Self| {
+            let backing = KBox::new(
+                RegistrationBacking {
+                    misc: Opaque::new(opts.into_raw::<T>()),
+                    data,
+                    owner: slot.cast_const(),
+                    registered: AtomicBool::new(false),
+                },
+                GFP_KERNEL,
+            )?;
+
+            // SAFETY: `slot` is valid for writes for the duration of this initializer.
+            unsafe {
+                slot.write(Self {
+                    backing,
+                    _pin: PhantomPinned,
+                    _t: PhantomData,
+                })
+            };
+
+            // SAFETY: `slot` points to the fully-initialized registration wrapper we just wrote
+            // above.
+            let this = unsafe { &mut *slot };
+            // SAFETY: `this.as_raw()` points at the fully initialized `struct miscdevice`
+            // contained in the heap-backed registration backing.
+            let ret = to_result(unsafe { bindings::misc_register(this.as_raw()) });
+            if let Err(err) = ret {
+                // SAFETY: The wrapper was fully initialized above, so dropping it here correctly
+                // releases the heap-backed registration backing.
+                unsafe { drop_in_place(slot) };
+                return Err(err);
+            }
+
+            this.backing.registered.store(true, Ordering::Release);
+            Ok(())
+        };
+
+        // SAFETY:
+        // - On success, the closure writes a fully-initialized `Self` into `slot` before making
+        //   the miscdevice visible via `misc_register()`. All state observable through the safe
+        //   open context is initialized before publication.
+        // - On failure after the write, it drops the initialized value before returning.
+        unsafe { pin_init::pin_init_from_closure(init) }
+    }
+
+    /// Returns the registration wrapper for a raw `struct miscdevice` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `misc` must point at the `misc` field of a live [`RegistrationBacking<T>`].
+    unsafe fn from_raw_misc<'a>(misc: *mut bindings::miscdevice) -> &'a Self {
+        // SAFETY: The caller guarantees that `misc` points at the `misc` field of a live
+        // `RegistrationBacking<T>`, whose `owner` points back to the live registration wrapper.
+        let backing =
+            unsafe { &*container_of!(Opaque::cast_from(misc), RegistrationBacking<T>, misc) };
+        // SAFETY: By the type invariant, `owner` points at the live wrapper that owns `backing`.
+        unsafe { &*backing.owner }
     }
 
     /// Returns a raw pointer to the misc device.
     pub fn as_raw(&self) -> *mut bindings::miscdevice {
-        self.inner.get()
+        self.backing.misc.get()
+    }
+
+    /// Returns the registration data that was supplied at registration time.
+    pub fn data(&self) -> &T::RegistrationData {
+        &self.backing.data
+    }
+
+    fn deregister_inner(backing: &RegistrationBacking<T>) {
+        if backing.registered.swap(false, Ordering::AcqRel) {
+            // SAFETY: `registered == true` guarantees that the miscdevice was successfully
+            // registered and has not been deregistered yet.
+            unsafe { bindings::misc_deregister(backing.misc.get()) };
+        }
     }
 
-    /// Access the `this_device` field.
-    pub fn device(&self) -> &Device {
-        // SAFETY: This can only be called after a successful register(), which always
-        // initialises `this_device` with a valid device. Furthermore, the signature of this
-        // function tells the borrow-checker that the `&Device` reference must not outlive the
-        // `&MiscDeviceRegistration<T>` used to obtain it, so the last use of the reference must be
-        // before the underlying `struct miscdevice` is destroyed.
-        unsafe { Device::from_raw((*self.as_raw()).this_device) }
+    /// Deregister this misc device if it is still registered.
+    ///
+    /// After this returns, the misc core will no longer route new opens to [`MiscDevice::open`].
+    /// Existing open files keep their own pinned `file_operations` table and private data and must
+    /// be drained by the driver before it tears down device-side resources that those file handles
+    /// still own.
+    pub fn deregister(&self) {
+        Self::deregister_inner(&self.backing);
     }
 }
 
 #[pinned_drop]
-impl<T> PinnedDrop for MiscDeviceRegistration<T> {
+impl<T: MiscDevice + 'static> PinnedDrop for MiscDeviceRegistration<T> {
     fn drop(self: Pin<&mut Self>) {
-        // SAFETY: We know that the device is registered by the type invariants.
-        unsafe { bindings::misc_deregister(self.inner.get()) };
+        let this = self.project();
+        Self::deregister_inner(this.backing);
+    }
+}
+
+/// Publication-safe context passed to [`MiscDevice::open`].
+pub struct MiscDeviceOpenContext<'a, T: MiscDevice + 'static> {
+    registration: &'a MiscDeviceRegistration<T>,
+    device: ARef<Device>,
+}
+
+impl<'a, T: MiscDevice + 'static> MiscDeviceOpenContext<'a, T> {
+    /// Returns the registration data supplied at registration time.
+    pub fn data(&self) -> &T::RegistrationData {
+        self.registration.data()
+    }
+
+    /// Returns the class device backing this miscdevice open.
+    pub fn device(&self) -> ARef<Device> {
+        self.device.clone()
     }
 }
 
+/// Internal trait that supplies the concrete `file_operations` table used for a Rust miscdevice.
+///
+/// # Safety
+///
+/// Implementations must return a stable `file_operations` table produced by this abstraction so
+/// that owner/module pinning and the private-data protocol remain intact. Drivers should use
+/// [`declare_misc_device_fops!`] instead of implementing this trait manually.
+#[doc(hidden)]
+pub unsafe trait MiscDeviceVTable: MiscDevice + 'static {
+    /// Returns the `file_operations` table for this miscdevice implementation.
+    fn file_operations() -> &'static bindings::file_operations;
+}
+
 /// Trait implemented by the private data of an open misc device.
 #[vtable]
 pub trait MiscDevice: Sized {
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
 
+    /// Driver-defined data stored in the miscdevice registration.
+    type RegistrationData: Send + Sync + 'static;
+
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
-    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
+    fn open(_file: &File, _ctx: &MiscDeviceOpenContext<'_, Self>) -> Result<Self::Ptr>;
 
     /// Called when the misc device is released.
     fn release(device: Self::Ptr, _file: &File) {
@@ -195,7 +366,45 @@ fn show_fdinfo(
 /// A vtable for the file operations of a Rust miscdevice.
 struct MiscdeviceVTable<T: MiscDevice>(PhantomData<T>);
 
-impl<T: MiscDevice> MiscdeviceVTable<T> {
+impl<T: MiscDevice + 'static> MiscdeviceVTable<T> {
+    const fn build(owner: *mut bindings::module) -> bindings::file_operations {
+        bindings::file_operations {
+            owner,
+            open: Some(Self::open),
+            release: Some(Self::release),
+            mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
+            read_iter: if T::HAS_READ_ITER {
+                Some(Self::read_iter)
+            } else {
+                None
+            },
+            write_iter: if T::HAS_WRITE_ITER {
+                Some(Self::write_iter)
+            } else {
+                None
+            },
+            unlocked_ioctl: if T::HAS_IOCTL {
+                Some(Self::ioctl)
+            } else {
+                None
+            },
+            #[cfg(CONFIG_COMPAT)]
+            compat_ioctl: if T::HAS_COMPAT_IOCTL {
+                Some(Self::compat_ioctl)
+            } else if T::HAS_IOCTL {
+                bindings::compat_ptr_ioctl
+            } else {
+                None
+            },
+            show_fdinfo: if T::HAS_SHOW_FDINFO {
+                Some(Self::show_fdinfo)
+            } else {
+                None
+            },
+            ..pin_init::zeroed()
+        }
+    }
+
     /// # Safety
     ///
     /// `file` and `inode` must be the file and inode for a file that is undergoing initialization.
@@ -214,25 +423,38 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         // associated `struct miscdevice` before calling into this method. Furthermore,
         // `misc_open()` ensures that the miscdevice can't be unregistered and freed during this
         // call to `fops_open`.
-        let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
+        let misc = unsafe { MiscDeviceRegistration::<T>::from_raw_misc(misc_ptr.cast()) };
 
         // SAFETY:
         // * This underlying file is valid for (much longer than) the duration of `T::open`.
         // * There is no active fdget_pos region on the file on this thread.
         let file = unsafe { File::from_raw_file(raw_file) };
 
-        let ptr = match T::open(file, misc) {
+        // SAFETY: `misc_open()` serializes with `misc_deregister()` via `misc_mtx`, so the class
+        // device remains live for the duration of this callback. Taking an extra reference here
+        // lets the safe open context own the device independently from later teardown.
+        let ctx = MiscDeviceOpenContext {
+            registration: misc,
+            device: unsafe { Device::get_device((*misc.as_raw()).this_device) },
+        };
+
+        let ptr = match T::open(file, &ctx) {
             Ok(ptr) => ptr,
             Err(err) => return err.to_errno(),
         };
+        let ptr = ScopeGuard::new_with_data(ptr, |ptr| T::release(ptr, file));
 
-        // This overwrites the private data with the value specified by the user, changing the type
-        // of this file's private data. All future accesses to the private data is performed by
-        // other fops_* methods in this file, which all correctly cast the private data to the new
-        // type.
+        let mut open_file = match KBox::new(OpenFile::<T>::empty(), GFP_KERNEL) {
+            Ok(open_file) => open_file,
+            Err(_) => return ENOMEM.to_errno(),
+        };
+        open_file.data = ptr.dismiss().into_foreign();
+
+        // This overwrites the private data with a small Rust-owned wrapper that keeps the module
+        // pinned for the full file lifetime and owns the driver's foreign private data handle.
         //
         // SAFETY: The open call of a file can access the private data.
-        unsafe { (*raw_file).private_data = ptr.into_foreign() };
+        unsafe { (*raw_file).private_data = open_file.into_foreign() };
 
         0
     }
@@ -243,14 +465,17 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// must be associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn release(_inode: *mut bindings::inode, file: *mut bindings::file) -> c_int {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data };
-        // SAFETY: The release call of a file owns the private data.
-        let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
+        let open_file =
+            unsafe { <KBox<OpenFile<T>> as ForeignOwnable>::from_foreign((*file).private_data) };
+        let data = open_file.data;
 
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this thread.
-        T::release(ptr, unsafe { File::from_raw_file(file) });
+        T::release(
+            unsafe { <T::Ptr as ForeignOwnable>::from_foreign(data) },
+            unsafe { File::from_raw_file(file) },
+        );
 
         0
     }
@@ -304,11 +529,9 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         vma: *mut bindings::vm_area_struct,
     ) -> c_int {
         // SAFETY: The mmap call of a file can access the private data.
-        let private = unsafe { (*file).private_data };
-        // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in `open` and
-        // `from_foreign` in `release`, and `fops_mmap` is guaranteed to be called between those
-        // two operations.
-        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private.cast()) };
+        let open_file =
+            unsafe { <KBox<OpenFile<T>> as ForeignOwnable>::borrow((*file).private_data) };
+        let device = open_file.borrow();
         // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
         let area = unsafe { VmaNew::from_raw(vma) };
         // SAFETY:
@@ -327,9 +550,9 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn ioctl(file: *mut bindings::file, cmd: c_uint, arg: c_ulong) -> c_long {
         // SAFETY: The ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data };
-        // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        let open_file =
+            unsafe { <KBox<OpenFile<T>> as ForeignOwnable>::borrow((*file).private_data) };
+        let device = open_file.borrow();
 
         // SAFETY:
         // * The file is valid for the duration of this call.
@@ -352,9 +575,9 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         arg: c_ulong,
     ) -> c_long {
         // SAFETY: The compat ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data };
-        // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        let open_file =
+            unsafe { <KBox<OpenFile<T>> as ForeignOwnable>::borrow((*file).private_data) };
+        let device = open_file.borrow();
 
         // SAFETY:
         // * The file is valid for the duration of this call.
@@ -373,9 +596,9 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// - `seq_file` must be a valid `struct seq_file` that we can write to.
     unsafe extern "C" fn show_fdinfo(seq_file: *mut bindings::seq_file, file: *mut bindings::file) {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data };
-        // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        let open_file =
+            unsafe { <KBox<OpenFile<T>> as ForeignOwnable>::borrow((*file).private_data) };
+        let device = open_file.borrow();
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this thread.
@@ -386,43 +609,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
 
         T::show_fdinfo(device, m, file);
     }
+}
 
-    const VTABLE: bindings::file_operations = bindings::file_operations {
-        open: Some(Self::open),
-        release: Some(Self::release),
-        mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
-        read_iter: if T::HAS_READ_ITER {
-            Some(Self::read_iter)
-        } else {
-            None
-        },
-        write_iter: if T::HAS_WRITE_ITER {
-            Some(Self::write_iter)
-        } else {
-            None
-        },
-        unlocked_ioctl: if T::HAS_IOCTL {
-            Some(Self::ioctl)
-        } else {
-            None
-        },
-        #[cfg(CONFIG_COMPAT)]
-        compat_ioctl: if T::HAS_COMPAT_IOCTL {
-            Some(Self::compat_ioctl)
-        } else if T::HAS_IOCTL {
-            bindings::compat_ptr_ioctl
-        } else {
-            None
-        },
-        show_fdinfo: if T::HAS_SHOW_FDINFO {
-            Some(Self::show_fdinfo)
-        } else {
-            None
-        },
-        ..pin_init::zeroed()
-    };
-
-    const fn build() -> &'static bindings::file_operations {
-        &Self::VTABLE
-    }
+#[doc(hidden)]
+pub const fn build_file_operations<T: MiscDevice + 'static>(
+    owner: *mut bindings::module,
+) -> bindings::file_operations {
+    MiscdeviceVTable::<T>::build(owner)
 }
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 87a1fe63533a..f2d7a98a5715 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -100,7 +100,7 @@
     fs::{File, Kiocb},
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     iov::{IovIterDest, IovIterSource},
-    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    miscdevice::{MiscDevice, MiscDeviceOpenContext, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
     sync::{aref::ARef, Mutex},
@@ -154,9 +154,10 @@ struct RustMiscDevice {
 #[vtable]
 impl MiscDevice for RustMiscDevice {
     type Ptr = Pin<KBox<Self>>;
+    type RegistrationData = ();
 
-    fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Self>>> {
-        let dev = ARef::from(misc.device());
+    fn open(_file: &File, ctx: &MiscDeviceOpenContext<'_, Self>) -> Result<Pin<KBox<Self>>> {
+        let dev = ctx.device();
 
         dev_info!(dev, "Opening Rust Misc Device Sample\n");
 
@@ -222,6 +223,8 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result
     }
 }
 
+kernel::declare_misc_device_fops!(RustMiscDevice);
+
 #[pinned_drop]
 impl PinnedDrop for RustMiscDevice {
     fn drop(self: Pin<&mut Self>) {
-- 
2.34.1


