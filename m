Return-Path: <linux-api+bounces-6062-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNFoO/Xl02n/ngcAu9opvQ
	(envelope-from <linux-api+bounces-6062-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 18:57:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9833A57D3
	for <lists+linux-api@lfdr.de>; Mon, 06 Apr 2026 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E2B43017C33
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161938B7DE;
	Mon,  6 Apr 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="OIBZWDGJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-m81201.netease.com (mail-m81201.netease.com [47.88.81.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC431985C;
	Mon,  6 Apr 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.88.81.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494623; cv=none; b=H7X7FeCUcMgLtwTnv6Bk/E+nEnyLy4Avm0TJxH4O3JgzU+Nmvi3+KJD3bSU7JPolE/E5lIrfLyG0ud6fKwbYTgTGTBzNH/vAPEkvQ3iiiytfy5+sVifbhaFFvSQHdEKmU+zxNY4NZIOLIw1wkRyN7aWKJ1luDU3LwIjcr17xI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494623; c=relaxed/simple;
	bh=q24PgbY4dBpyVU6n1W0t5u+dpP3e1xtJm8tpu+KWqms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObnQq8iAxXfMNmLsnbmMO3d178m4jaq/cOiOzHHsltN34nVb+QTjKXjNUgmPs7XwJhQi+72CLgZrF09DkA1JR7lX9eGVr82/+BYopjAmObeqbiwz/wMVLA/8vY1gF+h1yLOM/YYP9Qq/9rnZf3LSu7RWdAU3r0msulNE94+Ojm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=OIBZWDGJ; arc=none smtp.client-ip=47.88.81.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39aaefbde;
	Tue, 7 Apr 2026 00:51:38 +0800 (GMT+08:00)
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
Subject: [RFC PATCH v3 4/6] rust: pci: add shared BAR memremap support
Date: Mon,  6 Apr 2026 12:51:18 -0400
Message-Id: <20260406165120.166928-5-wenzhaoliao@ruc.edu.cn>
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
X-HM-Tid: 0a9d63b4fbc603a2kunm562d3b0d647e84
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHRpPVhpJTE5DQh5ITx5IQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=OIBZWDGJEqJkkA2iSxbF45HhcYWe45TyqchoARpp4RJyzrduzeBQn2zcxBRGhqrfCfxacWKlk+upvfcQFJioeXB14moc1g1Pkc/b9IU1hq+JzmgP3QmODugKnf09WT0rgOozoN02KZiW/7vE+ZvPYyGHTrBBnIBM3ptkFRLAWIY=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=ZgC0mjQ5RQBGocLST6WuNwU3qiYPju/tIc008Tntz3c=;
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
	TAGGED_FROM(0.00)[bounces-6062-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid]
X-Rspamd-Queue-Id: 8F9833A57D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a small Rust-owned abstraction for PCI BARs that back shared memory
instead of register MMIO.

The new SharedMemoryBar type owns both the BAR reservation and the
memremap() lifetime, exposes the physical BAR start needed by the
address-space ping path, and keeps the resource bookkeeping out of the
Rust driver.

The current RFC no longer exposes userspace mmap, but the driver still
needs an owned shared-BAR reservation and the BAR's physical base for
the ping path. Keeping the reservation/memremap() pairing in a Rust
abstraction avoids pushing that lifetime bookkeeping back into driver
code.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/pci.rs    |   8 +++
 rust/kernel/pci/id.rs |   2 +-
 rust/kernel/pci/io.rs | 112 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..4c63c931ffb2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -47,6 +47,7 @@
     ConfigSpaceSize,
     Extended,
     Normal, //
+    SharedMemoryBar,
 };
 pub use self::irq::{
     IrqType,
@@ -458,6 +459,13 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Disable this PCI device.
+    #[inline]
+    pub fn disable_device(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_disable_device(self.as_raw()) };
+    }
 }
 
 // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 50005d176561..bd3cf17fd8de 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -156,7 +156,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 impl Vendor {
     /// Create a Vendor from a raw 16-bit vendor ID.
     #[inline]
-    pub(super) fn from_raw(vendor_id: u16) -> Self {
+    pub const fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
     }
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index fb6edab2aea7..89bf882b9634 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -7,6 +7,7 @@
     bindings,
     device,
     devres::Devres,
+    ffi::{c_ulong, c_void},
     io::{
         io_define_read,
         io_define_write,
@@ -17,11 +18,13 @@
         MmioRaw, //
     },
     prelude::*,
-    sync::aref::ARef, //
+    sync::aref::ARef,
+    types::ScopeGuard,
 };
 use core::{
     marker::PhantomData,
     ops::Deref, //
+    ptr::NonNull,
 };
 
 /// Represents the size of a PCI configuration space.
@@ -285,6 +288,104 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+/// A cacheable shared-memory mapping of a PCI BAR created via `memremap()`.
+///
+/// This is intended for BARs that back shared memory rather than device register MMIO. The
+/// mapping owns both the underlying PCI region reservation and the `memremap()` lifetime, so
+/// driver code does not need to keep raw pointers or manually pair teardown calls.
+pub struct SharedMemoryBar {
+    pdev: ARef<Device>,
+    addr: NonNull<c_void>,
+    phys_start: bindings::resource_size_t,
+    len: usize,
+    num: i32,
+}
+
+// SAFETY: `SharedMemoryBar` owns a stable BAR reservation plus its `memremap()` mapping. Moving
+// the owner to another thread does not change the validity of the underlying PCI resource.
+unsafe impl Send for SharedMemoryBar {}
+
+// SAFETY: Shared references only expose immutable metadata queries; the mapped pointer itself is
+// not exposed for dereferencing.
+unsafe impl Sync for SharedMemoryBar {}
+
+impl SharedMemoryBar {
+    fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+        if !Bar::index_is_valid(num) {
+            return Err(EINVAL);
+        }
+
+        let len = pdev.resource_len(num)?;
+        if len == 0 {
+            return Err(ENXIO);
+        }
+
+        let len = usize::try_from(len)?;
+        let phys_start = pdev.resource_start(num)?;
+        let num = i32::try_from(num)?;
+
+        // SAFETY:
+        // - `pdev` is valid by the invariants of `Device`.
+        // - `num` is checked above.
+        // - `name` is a valid NUL-terminated string.
+        let ret = unsafe { bindings::pci_request_region(pdev.as_raw(), num, name.as_char_ptr()) };
+        if ret != 0 {
+            return Err(EBUSY);
+        }
+
+        let release_region = ScopeGuard::new(|| {
+            // SAFETY:
+            // - `pdev` is still valid for the duration of this constructor.
+            // - `num` has just been successfully reserved.
+            unsafe { bindings::pci_release_region(pdev.as_raw(), num) };
+        });
+
+        // SAFETY:
+        // - `phys_start`/`len` describe the BAR range we just reserved.
+        // - `MEMREMAP_WB` matches the external goldfish driver behaviour.
+        let addr = unsafe { bindings::memremap(phys_start, len, bindings::MEMREMAP_WB as c_ulong) };
+        let addr = NonNull::new(addr.cast()).ok_or(ENOMEM)?;
+
+        release_region.dismiss();
+
+        Ok(Self {
+            pdev: pdev.into(),
+            addr,
+            phys_start,
+            len,
+            num,
+        })
+    }
+
+    /// Returns the physical start address of the BAR.
+    #[inline]
+    pub fn phys_start(&self) -> bindings::resource_size_t {
+        self.phys_start
+    }
+
+    /// Returns the BAR size in bytes.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    fn release(&self) {
+        // SAFETY:
+        // - `self.addr` is a valid `memremap()` result owned by `self`.
+        // - `self.num` is the BAR region successfully reserved by `Self::new`.
+        unsafe {
+            bindings::memunmap(self.addr.as_ptr().cast());
+            bindings::pci_release_region(self.pdev.as_raw(), self.num);
+        }
+    }
+}
+
+impl Drop for SharedMemoryBar {
+    fn drop(&mut self) {
+        self.release();
+    }
+}
+
 impl Device<device::Bound> {
     /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
@@ -305,6 +406,15 @@ pub fn iomap_region<'a>(
         self.iomap_region_sized::<0>(bar, name)
     }
 
+    /// Reserve and `memremap()` an entire PCI BAR as cacheable shared memory.
+    pub fn memremap_bar<'a>(
+        &'a self,
+        bar: u32,
+        name: &'a CStr,
+    ) -> impl PinInit<Devres<SharedMemoryBar>, Error> + 'a {
+        Devres::new(self.as_ref(), SharedMemoryBar::new(self, bar, name))
+    }
+
     /// Returns the size of configuration space.
     pub fn cfg_size(&self) -> ConfigSpaceSize {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-- 
2.34.1

