Return-Path: <linux-api+bounces-6066-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG2QMi811GnYsAcAu9opvQ
	(envelope-from <linux-api+bounces-6066-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 00:35:27 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA63A7E53
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 00:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4094303FFAD
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2026 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C839D6DE;
	Mon,  6 Apr 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="XBBJMEfR"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-m81141.netease.com (mail-m81141.netease.com [47.88.81.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C862DCF55;
	Mon,  6 Apr 2026 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.88.81.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514901; cv=none; b=cpb2YSDDafKd4zAzlKtRN+0+VXO6zaOucmfAAnu911v/wAul8ER7FdRIGHDqyKDELuQEVNVF+uqF7+6rKNFf7yGcfuOwiAyWEfEAVBm4lk/7E1NL1gBhxjgIW7YqRWbN4ONIqcLmNFLITZq21YCkZO8LkuqzbxUcs0xqwAHT0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514901; c=relaxed/simple;
	bh=dRHAE3I/SWqaGNIaJvkyVijNPIt2j+9ekFM0wXRPM/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqWIHRqq5luBN+jT9js04syEZ7aYfFJ5XctDNc5bdfu8yDakCUUVpaU7GPo9c5KzPKplGHgh+HO5Tvw3k8fLy62AbVvbG9zC0lWc/+zf5X/rBNyVwWvR9LggdDLcB6PVveobztLkH/hRisG+aXPcfnItUzgZN/LrLPboESkaCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=XBBJMEfR; arc=none smtp.client-ip=47.88.81.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39aaefbe1;
	Tue, 7 Apr 2026 00:51:46 +0800 (GMT+08:00)
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
Subject: [RFC PATCH v3 6/6] platform/goldfish: add Rust goldfish_address_space driver
Date: Mon,  6 Apr 2026 12:51:20 -0400
Message-Id: <20260406165120.166928-7-wenzhaoliao@ruc.edu.cn>
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
X-HM-Tid: 0a9d63b51ca203a2kunm562d3b0d647e93
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHhpLVk9CTBkYHkMYQxhLH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XBBJMEfRtlBC9iBF8DurdyoNTlCN1ZcrjeNulVRYg+NL3Ai5nwGU2kBWCXkUXHYfzKyJ8LGvc295BphjGd938chplOh95R5+ipVjHScfIzRYr+Xvv/mKgXam/sm27HuSGs1XyKxTzdKV8niGE3NMFaxSsjdPzAbxBGtmzTrl7vk=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=ED5Mu0ieMlJgd4INk+b0oEYvkKv8bjy1kvcUcApERQs=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6066-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2BAA63A7E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a Rust implementation of the goldfish address-space driver and wire
it into drivers/platform/goldfish.

This RFC intentionally scopes the driver to the open/release/ioctl ABI
subset; userspace mmap is not part of this series. The driver keeps all
unsafe and bindings-facing work inside the Rust abstraction layers,
carries #![forbid(unsafe_code)] in the driver crate, and uses typed
miscdevice registration data plus SharedMemoryBar to stay on the safe
side of those abstractions.

On teardown, unbind first deregisters the miscdevice, then drains
already-running operations and revokes live file-owned device state
before disabling the PCI function. Probe also pairs
enable_device_mem() with a ScopeGuard so mid-probe failures cannot leak
an enabled device.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 MAINTAINERS                                   |   2 +
 drivers/platform/goldfish/Kconfig             |  11 +
 drivers/platform/goldfish/Makefile            |   1 +
 .../goldfish/goldfish_address_space.rs        | 917 ++++++++++++++++++
 4 files changed, 931 insertions(+)
 create mode 100644 drivers/platform/goldfish/goldfish_address_space.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 800b2fe0e648..0a9193854f1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1888,7 +1888,9 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
+F:	drivers/platform/goldfish/goldfish_address_space.rs
 F:	include/uapi/linux/goldfish_address_space.h
+K:	\bGOLDFISH_ADDRESS_SPACE\b
 
 ANDROID GOLDFISH RTC DRIVER
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
index 03ca5bf19f98..58ccf5a757bd 100644
--- a/drivers/platform/goldfish/Kconfig
+++ b/drivers/platform/goldfish/Kconfig
@@ -17,4 +17,15 @@ config GOLDFISH_PIPE
 	  This is a virtual device to drive the QEMU pipe interface used by
 	  the Goldfish Android Virtual Device.
 
+config GOLDFISH_ADDRESS_SPACE
+	tristate "Goldfish address space driver in Rust"
+	depends on PCI && RUST && MMU
+	help
+	  Adds a Rust implementation of the Goldfish address space driver
+	  used by the Android Goldfish emulator.
+
+	  This implementation uses typed Rust abstractions for PCI resource
+	  setup, miscdevice registration, page-backed ping state, and the
+	  userspace ioctl interface.
+
 endif # GOLDFISH
diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index 76ba1d571896..17f67c223e95 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -3,3 +3,4 @@
 # Makefile for Goldfish platform specific drivers
 #
 obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
+obj-$(CONFIG_GOLDFISH_ADDRESS_SPACE) += goldfish_address_space.o
diff --git a/drivers/platform/goldfish/goldfish_address_space.rs b/drivers/platform/goldfish/goldfish_address_space.rs
new file mode 100644
index 000000000000..7742c76ea7fc
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_address_space.rs
@@ -0,0 +1,917 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Goldfish address space driver.
+
+#![forbid(unsafe_code)]
+
+use core::{mem::size_of, pin::Pin};
+use kernel::{
+    alloc::KVVec,
+    device::Core,
+    devres::Devres,
+    error::Error,
+    fs::File,
+    io::{Io, PhysAddr},
+    ioctl,
+    miscdevice::{MiscDevice, MiscDeviceOpenContext, MiscDeviceOptions, MiscDeviceRegistration},
+    new_condvar, new_mutex,
+    page::{Page, PAGE_SIZE},
+    pci,
+    prelude::*,
+    sync::{Arc, ArcBorrow, CondVar, Mutex},
+    types::ScopeGuard,
+    uaccess::{UserPtr, UserSlice},
+    uapi,
+};
+
+const GOLDFISH_AS_CONTROL_BAR: u32 = 0;
+const GOLDFISH_AS_AREA_BAR: u32 = 1;
+const GOLDFISH_AS_VENDOR_ID: u32 = 0x607d;
+const GOLDFISH_AS_DEVICE_ID: u32 = 0xf153;
+const GOLDFISH_AS_SUPPORTED_REVISION: u8 = 1;
+const GOLDFISH_AS_INVALID_HANDLE: u32 = u32::MAX;
+
+const GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC: u32 = uapi::GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC as u32;
+const GOLDFISH_ADDRESS_SPACE_IOCTL_ALLOCATE_BLOCK: u32 =
+    ioctl::_IOWR::<AllocateBlockIoctl>(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, 10);
+const GOLDFISH_ADDRESS_SPACE_IOCTL_DEALLOCATE_BLOCK: u32 =
+    ioctl::_IOWR::<u64>(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, 11);
+const GOLDFISH_ADDRESS_SPACE_IOCTL_PING: u32 =
+    ioctl::_IOWR::<PingIoctl>(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, 12);
+const GOLDFISH_ADDRESS_SPACE_IOCTL_CLAIM_SHARED: u32 =
+    ioctl::_IOWR::<ClaimSharedIoctl>(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, 13);
+const GOLDFISH_ADDRESS_SPACE_IOCTL_UNCLAIM_SHARED: u32 =
+    ioctl::_IOWR::<u64>(GOLDFISH_ADDRESS_SPACE_IOCTL_MAGIC, 14);
+
+struct Registers;
+
+impl Registers {
+    const COMMAND: usize = 0;
+    const STATUS: usize = 4;
+    const GUEST_PAGE_SIZE: usize = 8;
+    const BLOCK_SIZE_LOW: usize = 12;
+    const BLOCK_SIZE_HIGH: usize = 16;
+    const BLOCK_OFFSET_LOW: usize = 20;
+    const BLOCK_OFFSET_HIGH: usize = 24;
+    const PING: usize = 28;
+    const PING_INFO_ADDR_LOW: usize = 32;
+    const PING_INFO_ADDR_HIGH: usize = 36;
+    const HANDLE: usize = 40;
+    const PHYS_START_LOW: usize = 44;
+    const PHYS_START_HIGH: usize = 48;
+    const END: usize = 56;
+}
+
+#[repr(u32)]
+#[derive(Clone, Copy)]
+enum CommandId {
+    AllocateBlock = 1,
+    DeallocateBlock = 2,
+    GenHandle = 3,
+    DestroyHandle = 4,
+    TellPingInfoAddr = 5,
+}
+
+type ControlBar = pci::Bar<{ Registers::END }>;
+
+#[derive(Clone, Copy)]
+struct Block {
+    offset: u64,
+    size: u64,
+}
+
+struct BlockSet {
+    blocks: KVVec<Block>,
+}
+
+impl BlockSet {
+    fn new() -> Self {
+        Self {
+            blocks: KVVec::new(),
+        }
+    }
+
+    fn insert(&mut self, block: Block) -> Result {
+        self.blocks.push(block, GFP_KERNEL)?;
+        Ok(())
+    }
+
+    fn remove(&mut self, offset: u64) -> Result<Block> {
+        let index = self
+            .blocks
+            .iter()
+            .position(|block| block.offset == offset)
+            .ok_or(ENXIO)?;
+        self.blocks.remove(index).map_err(|_| EINVAL)
+    }
+
+    fn iter(&self) -> impl Iterator<Item = Block> + '_ {
+        self.blocks.iter().copied()
+    }
+
+    fn clear(&mut self) {
+        let _ = self.take_all();
+    }
+
+    fn take_all(&mut self) -> KVVec<Block> {
+        let mut blocks = KVVec::new();
+        core::mem::swap(&mut blocks, &mut self.blocks);
+        blocks
+    }
+}
+
+#[derive(Clone, Copy, Default)]
+struct PingInfoHeader {
+    offset: u64,
+    size: u64,
+    metadata: u64,
+    version: u32,
+    wait_fd: u32,
+    wait_flags: u32,
+    direction: u32,
+    data_size: u64,
+}
+
+impl PingInfoHeader {
+    const ENCODED_LEN: usize = 48;
+
+    fn encode(self) -> [u8; Self::ENCODED_LEN] {
+        let mut bytes = [0u8; Self::ENCODED_LEN];
+
+        bytes[0..8].copy_from_slice(&self.offset.to_ne_bytes());
+        bytes[8..16].copy_from_slice(&self.size.to_ne_bytes());
+        bytes[16..24].copy_from_slice(&self.metadata.to_ne_bytes());
+        bytes[24..28].copy_from_slice(&self.version.to_ne_bytes());
+        bytes[28..32].copy_from_slice(&self.wait_fd.to_ne_bytes());
+        bytes[32..36].copy_from_slice(&self.wait_flags.to_ne_bytes());
+        bytes[36..40].copy_from_slice(&self.direction.to_ne_bytes());
+        bytes[40..48].copy_from_slice(&self.data_size.to_ne_bytes());
+
+        bytes
+    }
+
+    fn decode(bytes: &[u8; Self::ENCODED_LEN]) -> Self {
+        Self {
+            offset: u64::from_ne_bytes(bytes[0..8].try_into().unwrap()),
+            size: u64::from_ne_bytes(bytes[8..16].try_into().unwrap()),
+            metadata: u64::from_ne_bytes(bytes[16..24].try_into().unwrap()),
+            version: u32::from_ne_bytes(bytes[24..28].try_into().unwrap()),
+            wait_fd: u32::from_ne_bytes(bytes[28..32].try_into().unwrap()),
+            wait_flags: u32::from_ne_bytes(bytes[32..36].try_into().unwrap()),
+            direction: u32::from_ne_bytes(bytes[36..40].try_into().unwrap()),
+            data_size: u64::from_ne_bytes(bytes[40..48].try_into().unwrap()),
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Clone, Copy, Default)]
+struct AllocateBlockIoctl {
+    size: u64,
+    offset: u64,
+    phys_addr: u64,
+}
+
+impl AllocateBlockIoctl {
+    const ENCODED_LEN: usize = 24;
+
+    fn encode(self) -> [u8; Self::ENCODED_LEN] {
+        let mut bytes = [0u8; Self::ENCODED_LEN];
+        bytes[0..8].copy_from_slice(&self.size.to_ne_bytes());
+        bytes[8..16].copy_from_slice(&self.offset.to_ne_bytes());
+        bytes[16..24].copy_from_slice(&self.phys_addr.to_ne_bytes());
+        bytes
+    }
+
+    fn decode(bytes: &[u8; Self::ENCODED_LEN]) -> Self {
+        Self {
+            size: u64::from_ne_bytes(bytes[0..8].try_into().unwrap()),
+            offset: u64::from_ne_bytes(bytes[8..16].try_into().unwrap()),
+            phys_addr: u64::from_ne_bytes(bytes[16..24].try_into().unwrap()),
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Clone, Copy, Default)]
+struct PingIoctl {
+    offset: u64,
+    size: u64,
+    metadata: u64,
+    version: u32,
+    wait_fd: u32,
+    wait_flags: u32,
+    direction: u32,
+}
+
+impl PingIoctl {
+    const ENCODED_LEN: usize = 40;
+
+    fn encode(self) -> [u8; Self::ENCODED_LEN] {
+        let mut bytes = [0u8; Self::ENCODED_LEN];
+        bytes[0..8].copy_from_slice(&self.offset.to_ne_bytes());
+        bytes[8..16].copy_from_slice(&self.size.to_ne_bytes());
+        bytes[16..24].copy_from_slice(&self.metadata.to_ne_bytes());
+        bytes[24..28].copy_from_slice(&self.version.to_ne_bytes());
+        bytes[28..32].copy_from_slice(&self.wait_fd.to_ne_bytes());
+        bytes[32..36].copy_from_slice(&self.wait_flags.to_ne_bytes());
+        bytes[36..40].copy_from_slice(&self.direction.to_ne_bytes());
+        bytes
+    }
+
+    fn decode(bytes: &[u8; Self::ENCODED_LEN]) -> Self {
+        Self {
+            offset: u64::from_ne_bytes(bytes[0..8].try_into().unwrap()),
+            size: u64::from_ne_bytes(bytes[8..16].try_into().unwrap()),
+            metadata: u64::from_ne_bytes(bytes[16..24].try_into().unwrap()),
+            version: u32::from_ne_bytes(bytes[24..28].try_into().unwrap()),
+            wait_fd: u32::from_ne_bytes(bytes[28..32].try_into().unwrap()),
+            wait_flags: u32::from_ne_bytes(bytes[32..36].try_into().unwrap()),
+            direction: u32::from_ne_bytes(bytes[36..40].try_into().unwrap()),
+        }
+    }
+}
+
+#[repr(C)]
+#[derive(Clone, Copy, Default)]
+struct ClaimSharedIoctl {
+    offset: u64,
+    size: u64,
+}
+
+impl ClaimSharedIoctl {
+    const ENCODED_LEN: usize = 16;
+
+    fn encode(self) -> [u8; Self::ENCODED_LEN] {
+        let mut bytes = [0u8; Self::ENCODED_LEN];
+        bytes[0..8].copy_from_slice(&self.offset.to_ne_bytes());
+        bytes[8..16].copy_from_slice(&self.size.to_ne_bytes());
+        bytes
+    }
+
+    fn decode(bytes: &[u8; Self::ENCODED_LEN]) -> Self {
+        Self {
+            offset: u64::from_ne_bytes(bytes[0..8].try_into().unwrap()),
+            size: u64::from_ne_bytes(bytes[8..16].try_into().unwrap()),
+        }
+    }
+}
+
+struct PingState {
+    page: Page,
+}
+
+impl PingState {
+    fn new() -> Result<Self> {
+        let mut page = Page::alloc_page(GFP_KERNEL)?;
+        page.fill_zero(0, PAGE_SIZE)?;
+        Ok(Self { page })
+    }
+
+    fn phys_addr(&self) -> PhysAddr {
+        self.page.phys_addr()
+    }
+
+    fn shared_offset(offset: u64, shared_phys_start: PhysAddr) -> Result<u64> {
+        let shared_phys_start = u64::try_from(shared_phys_start).map_err(|_| EOVERFLOW)?;
+        offset.checked_add(shared_phys_start).ok_or(EOVERFLOW)
+    }
+
+    fn prepare_ping(&mut self, request: &PingIoctl, shared_phys_start: PhysAddr) -> Result {
+        let header = PingInfoHeader {
+            offset: Self::shared_offset(request.offset, shared_phys_start)?,
+            size: request.size,
+            metadata: request.metadata,
+            version: request.version,
+            wait_fd: request.wait_fd,
+            wait_flags: request.wait_flags,
+            direction: request.direction,
+            data_size: 0,
+        };
+
+        self.page.fill_zero(0, PAGE_SIZE)?;
+        self.page.write_slice(&header.encode(), 0)
+    }
+
+    fn finish_ping(&self, request: &mut PingIoctl) -> Result {
+        let mut bytes = [0u8; PingInfoHeader::ENCODED_LEN];
+        self.page.read_slice(&mut bytes, 0)?;
+        let header = PingInfoHeader::decode(&bytes);
+        request.offset = header.offset;
+        request.size = header.size;
+        request.metadata = header.metadata;
+        request.version = header.version;
+        request.wait_fd = header.wait_fd;
+        request.wait_flags = header.wait_flags;
+        request.direction = header.direction;
+        Ok(())
+    }
+}
+
+#[pin_data]
+struct DeviceRuntime {
+    #[pin]
+    control_bar: Devres<ControlBar>,
+    #[pin]
+    shared_bar: Devres<pci::SharedMemoryBar>,
+    #[pin]
+    registers_lock: Mutex<()>,
+    #[pin]
+    lifecycle: Mutex<RuntimeLifecycleState>,
+    #[pin]
+    lifecycle_idle: CondVar,
+}
+
+struct RuntimeLifecycleState {
+    accepting_new_ops: bool,
+    active_ops: usize,
+    live_files: KVVec<Arc<FileState>>,
+}
+
+struct RuntimeOpGuard {
+    runtime: Arc<DeviceRuntime>,
+}
+
+impl Drop for RuntimeOpGuard {
+    fn drop(&mut self) {
+        let mut state = self.runtime.lifecycle.lock();
+        state.active_ops -= 1;
+        self.runtime.notify_if_idle(&state);
+    }
+}
+
+impl DeviceRuntime {
+    fn new(pdev: &pci::Device<Core>) -> Result<Arc<Self>> {
+        Arc::pin_init(
+            try_pin_init!(Self {
+                control_bar <- pdev.iomap_region_sized::<{ Registers::END }>(
+                    GOLDFISH_AS_CONTROL_BAR,
+                    c"goldfish_address_space/control",
+                ),
+                shared_bar <- pdev.memremap_bar(
+                    GOLDFISH_AS_AREA_BAR,
+                    c"goldfish_address_space/area",
+                ),
+                registers_lock <- new_mutex!(()),
+                lifecycle <- new_mutex!(RuntimeLifecycleState {
+                    accepting_new_ops: true,
+                    active_ops: 0,
+                    live_files: KVVec::new(),
+                }),
+                lifecycle_idle <- new_condvar!("goldfish_address_space/lifecycle_idle"),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    fn notify_if_idle(&self, state: &RuntimeLifecycleState) {
+        if !state.accepting_new_ops && state.active_ops == 0 {
+            self.lifecycle_idle.notify_all();
+        }
+    }
+
+    fn begin_operation(self: &Arc<Self>) -> Result<RuntimeOpGuard> {
+        let mut state = self.lifecycle.lock();
+        if !state.accepting_new_ops {
+            return Err(ENODEV);
+        }
+
+        state.active_ops = state.active_ops.checked_add(1).ok_or(EBUSY)?;
+        drop(state);
+
+        Ok(RuntimeOpGuard {
+            runtime: self.clone(),
+        })
+    }
+
+    fn register_live_file(&self, file: Arc<FileState>) -> Result {
+        let mut state = self.lifecycle.lock();
+        if !state.accepting_new_ops {
+            return Err(ENODEV);
+        }
+
+        state.live_files.push(file, GFP_KERNEL)?;
+        Ok(())
+    }
+
+    fn unregister_live_file(&self, file: &Arc<FileState>) {
+        let mut state = self.lifecycle.lock();
+        let Some(index) = state
+            .live_files
+            .iter()
+            .position(|entry| Arc::ptr_eq(entry, file))
+        else {
+            return;
+        };
+
+        if let Ok(entry) = state.live_files.remove(index) {
+            drop(entry);
+        }
+    }
+
+    fn shutdown(&self) {
+        let mut state = self.lifecycle.lock();
+        // `unbind()` removes miscdevice reachability before calling `shutdown()`. After that we
+        // only need to wait for already-entered syscalls to finish; live files are revoked below,
+        // so remove is no longer bounded by userspace deciding to close descriptors.
+        state.accepting_new_ops = false;
+
+        while state.active_ops != 0 {
+            self.lifecycle_idle.wait(&mut state);
+        }
+
+        let mut live_files = KVVec::new();
+        core::mem::swap(&mut live_files, &mut state.live_files);
+        drop(state);
+
+        for file in &live_files {
+            file.revoke_for_shutdown();
+        }
+    }
+
+    fn control_bar(&self) -> Result<impl core::ops::Deref<Target = ControlBar> + '_> {
+        self.control_bar.try_access().ok_or(ENXIO)
+    }
+
+    fn shared_bar(&self) -> Result<impl core::ops::Deref<Target = pci::SharedMemoryBar> + '_> {
+        self.shared_bar.try_access().ok_or(ENXIO)
+    }
+
+    fn run_command_locked(control: &ControlBar, command: CommandId) -> Result {
+        control.write32(command as u32, Registers::COMMAND);
+
+        let status = i32::try_from(control.read32(Registers::STATUS)).map_err(|_| EIO)?;
+        if status == 0 {
+            Ok(())
+        } else {
+            Err(Error::from_errno(-status))
+        }
+    }
+
+    fn issue_command_locked(control: &ControlBar, command: CommandId) {
+        control.write32(command as u32, Registers::COMMAND);
+    }
+
+    fn write_u64(control: &ControlBar, low_offset: usize, high_offset: usize, value: u64) {
+        control.write32(value as u32, low_offset);
+        control.write32((value >> 32) as u32, high_offset);
+    }
+
+    fn read_u64(control: &ControlBar, low_offset: usize, high_offset: usize) -> u64 {
+        u64::from(control.read32(low_offset)) | (u64::from(control.read32(high_offset)) << 32)
+    }
+
+    fn program_host_visible_state(&self) -> Result {
+        let control = self.control_bar()?;
+        let shared = self.shared_bar()?;
+        let phys_start = u64::try_from(shared.phys_start()).map_err(|_| EOVERFLOW)?;
+
+        control.write32(PAGE_SIZE as u32, Registers::GUEST_PAGE_SIZE);
+        Self::write_u64(
+            &control,
+            Registers::PHYS_START_LOW,
+            Registers::PHYS_START_HIGH,
+            phys_start,
+        );
+
+        Ok(())
+    }
+
+    fn shared_phys_start(&self) -> Result<PhysAddr> {
+        Ok(self.shared_bar()?.phys_start())
+    }
+
+    fn generate_handle(&self) -> Result<u32> {
+        let _guard = self.registers_lock.lock();
+        let control = self.control_bar()?;
+
+        // The external C driver does not gate `GEN_HANDLE` on the status register and instead
+        // validates completion by reading back the handle.
+        Self::issue_command_locked(&control, CommandId::GenHandle);
+
+        let handle = control.read32(Registers::HANDLE);
+        if handle == GOLDFISH_AS_INVALID_HANDLE {
+            return Err(EINVAL);
+        }
+
+        Ok(handle)
+    }
+
+    fn tell_ping_info_addr(&self, handle: u32, ping_info_phys: PhysAddr) -> Result {
+        let _guard = self.registers_lock.lock();
+        let control = self.control_bar()?;
+        let ping_info_phys = u64::try_from(ping_info_phys).map_err(|_| EOVERFLOW)?;
+
+        control.write32(handle, Registers::HANDLE);
+        Self::write_u64(
+            &control,
+            Registers::PING_INFO_ADDR_LOW,
+            Registers::PING_INFO_ADDR_HIGH,
+            ping_info_phys,
+        );
+        // The external C driver validates `TELL_PING_INFO_ADDR` through the echoed physical
+        // address rather than through the status register.
+        Self::issue_command_locked(&control, CommandId::TellPingInfoAddr);
+
+        let returned = Self::read_u64(
+            &control,
+            Registers::PING_INFO_ADDR_LOW,
+            Registers::PING_INFO_ADDR_HIGH,
+        );
+        if returned != ping_info_phys {
+            return Err(EINVAL);
+        }
+
+        Ok(())
+    }
+
+    fn destroy_handle(&self, handle: u32) -> Result {
+        let _guard = self.registers_lock.lock();
+        let control = self.control_bar()?;
+        control.write32(handle, Registers::HANDLE);
+        Self::issue_command_locked(&control, CommandId::DestroyHandle);
+        Ok(())
+    }
+
+    fn allocate_block(&self, size: u64) -> Result<Block> {
+        let _guard = self.registers_lock.lock();
+        let control = self.control_bar()?;
+
+        Self::write_u64(
+            &control,
+            Registers::BLOCK_SIZE_LOW,
+            Registers::BLOCK_SIZE_HIGH,
+            size,
+        );
+        Self::run_command_locked(&control, CommandId::AllocateBlock)?;
+
+        Ok(Block {
+            offset: Self::read_u64(
+                &control,
+                Registers::BLOCK_OFFSET_LOW,
+                Registers::BLOCK_OFFSET_HIGH,
+            ),
+            size: Self::read_u64(
+                &control,
+                Registers::BLOCK_SIZE_LOW,
+                Registers::BLOCK_SIZE_HIGH,
+            ),
+        })
+    }
+
+    fn deallocate_block(&self, offset: u64) -> Result {
+        let _guard = self.registers_lock.lock();
+        let control = self.control_bar()?;
+        Self::write_u64(
+            &control,
+            Registers::BLOCK_OFFSET_LOW,
+            Registers::BLOCK_OFFSET_HIGH,
+            offset,
+        );
+        Self::run_command_locked(&control, CommandId::DeallocateBlock)
+    }
+
+    fn ping(&self, handle: u32) -> Result {
+        let _guard = self.registers_lock.lock();
+        self.control_bar()?.write32(handle, Registers::PING);
+        Ok(())
+    }
+
+    fn cleanup_file_resources<I>(&self, handle: u32, blocks: I)
+    where
+        I: IntoIterator<Item = Block>,
+    {
+        // `unbind()` revokes live files before `disable_device()`, so both the shutdown path and a
+        // concurrent `release()` may still legitimately touch the BAR here.
+        if let Err(err) = self.destroy_handle(handle) {
+            pr_warn!(
+                "goldfish_address_space: destroy handle {} failed: {}\n",
+                handle,
+                err.to_errno()
+            );
+        }
+
+        for block in blocks {
+            if let Err(err) = self.deallocate_block(block.offset) {
+                pr_warn!(
+                    "goldfish_address_space: deallocate block 0x{:x} failed: {}\n",
+                    block.offset,
+                    err.to_errno()
+                );
+            }
+        }
+    }
+}
+
+struct FileResources {
+    handle: Option<u32>,
+    allocated_blocks: BlockSet,
+    shared_blocks: BlockSet,
+}
+
+impl FileResources {
+    fn new(handle: u32) -> Self {
+        Self {
+            handle: Some(handle),
+            allocated_blocks: BlockSet::new(),
+            shared_blocks: BlockSet::new(),
+        }
+    }
+}
+
+#[pin_data]
+struct FileState {
+    runtime: Arc<DeviceRuntime>,
+    #[pin]
+    ping: Mutex<PingState>,
+    #[pin]
+    resources: Mutex<FileResources>,
+}
+
+impl FileState {
+    fn new(runtime: Arc<DeviceRuntime>, handle: u32, ping: PingState) -> Result<Arc<Self>> {
+        Arc::pin_init(
+            try_pin_init!(Self {
+                runtime: runtime,
+                ping <- new_mutex!(ping),
+                resources <- new_mutex!(FileResources::new(handle)),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    fn shared_phys_addr(&self, offset: u64) -> Result<u64> {
+        let base = u64::try_from(self.runtime.shared_phys_start()?).map_err(|_| EOVERFLOW)?;
+        base.checked_add(offset).ok_or(EOVERFLOW)
+    }
+
+    fn allocate_block(
+        self: ArcBorrow<'_, Self>,
+        mut request: AllocateBlockIoctl,
+    ) -> Result<AllocateBlockIoctl> {
+        let block = self.runtime.allocate_block(request.size)?;
+        let mut resources = self.resources.lock();
+        if resources.handle.is_none() {
+            drop(resources);
+            let _ = self.runtime.deallocate_block(block.offset);
+            return Err(ENODEV);
+        }
+
+        if let Err(err) = resources.allocated_blocks.insert(block) {
+            drop(resources);
+            let _ = self.runtime.deallocate_block(block.offset);
+            return Err(err);
+        }
+
+        request.size = block.size;
+        request.offset = block.offset;
+        request.phys_addr = self.shared_phys_addr(block.offset)?;
+        Ok(request)
+    }
+
+    fn deallocate_block(self: ArcBorrow<'_, Self>, offset: u64) -> Result {
+        let mut resources = self.resources.lock();
+        if resources.handle.is_none() {
+            return Err(ENODEV);
+        }
+
+        if !resources
+            .allocated_blocks
+            .iter()
+            .any(|block| block.offset == offset)
+        {
+            return Err(ENXIO);
+        }
+
+        self.runtime.deallocate_block(offset)?;
+        let _ = resources.allocated_blocks.remove(offset)?;
+        Ok(())
+    }
+
+    fn claim_shared(
+        self: ArcBorrow<'_, Self>,
+        request: ClaimSharedIoctl,
+    ) -> Result<ClaimSharedIoctl> {
+        let mut resources = self.resources.lock();
+        if resources.handle.is_none() {
+            return Err(ENODEV);
+        }
+
+        resources.shared_blocks.insert(Block {
+            offset: request.offset,
+            size: request.size,
+        })?;
+        Ok(request)
+    }
+
+    fn unclaim_shared(self: ArcBorrow<'_, Self>, offset: u64) -> Result {
+        let mut resources = self.resources.lock();
+        if resources.handle.is_none() {
+            return Err(ENODEV);
+        }
+
+        resources.shared_blocks.remove(offset)?;
+        Ok(())
+    }
+
+    fn ping(self: ArcBorrow<'_, Self>, mut request: PingIoctl) -> Result<PingIoctl> {
+        let handle = self.resources.lock().handle.ok_or(ENODEV)?;
+        let mut ping = self.ping.lock();
+        ping.prepare_ping(&request, self.runtime.shared_phys_start()?)?;
+        self.runtime.ping(handle)?;
+        ping.finish_ping(&mut request)?;
+        Ok(request)
+    }
+
+    fn cleanup_resources(&self) {
+        let mut resources = self.resources.lock();
+        let Some(handle) = resources.handle.take() else {
+            return;
+        };
+
+        self.runtime
+            .cleanup_file_resources(handle, resources.allocated_blocks.iter());
+        resources.allocated_blocks.clear();
+        resources.shared_blocks.clear();
+    }
+
+    fn revoke_for_shutdown(&self) {
+        self.cleanup_resources();
+    }
+
+    fn release(self: Arc<Self>) {
+        self.cleanup_resources();
+        self.runtime.unregister_live_file(&self);
+    }
+}
+
+#[pin_data]
+struct GoldfishAddressSpaceDriver {
+    runtime: Arc<DeviceRuntime>,
+    #[pin]
+    misc: MiscDeviceRegistration<GoldfishAddressSpaceMisc>,
+}
+
+struct GoldfishAddressSpaceMisc;
+
+#[vtable]
+impl MiscDevice for GoldfishAddressSpaceMisc {
+    type Ptr = Arc<FileState>;
+    type RegistrationData = Arc<DeviceRuntime>;
+
+    fn open(_file: &File, ctx: &MiscDeviceOpenContext<'_, Self>) -> Result<Self::Ptr> {
+        let runtime = ctx.data().clone();
+        let _op = runtime.begin_operation()?;
+        let ping = PingState::new()?;
+        let handle = runtime.generate_handle()?;
+        let cleanup = ScopeGuard::new_with_data((runtime.clone(), handle), |(runtime, handle)| {
+            let _ = runtime.destroy_handle(handle);
+        });
+
+        runtime.tell_ping_info_addr(handle, ping.phys_addr())?;
+        let state = FileState::new(runtime.clone(), handle, ping)?;
+        cleanup.dismiss();
+
+        // Publish the file as a live shutdown owner before returning it to the miscdevice core.
+        if let Err(err) = runtime.register_live_file(state.clone()) {
+            state.release();
+            return Err(err);
+        }
+
+        Ok(state)
+    }
+
+    fn release(device: Self::Ptr, _file: &File) {
+        device.release();
+    }
+
+    fn ioctl(
+        device: ArcBorrow<'_, FileState>,
+        _file: &File,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize> {
+        let _op = device.runtime.begin_operation()?;
+        match cmd {
+            GOLDFISH_ADDRESS_SPACE_IOCTL_ALLOCATE_BLOCK => {
+                let data = UserSlice::new(UserPtr::from_addr(arg), AllocateBlockIoctl::ENCODED_LEN);
+                let (mut reader, mut writer) = data.reader_writer();
+                let mut bytes = [0u8; AllocateBlockIoctl::ENCODED_LEN];
+                reader.read_slice(&mut bytes)?;
+                let request = AllocateBlockIoctl::decode(&bytes);
+                let response = device.allocate_block(request)?;
+                writer.write_slice(&response.encode())?;
+                Ok(0)
+            }
+            GOLDFISH_ADDRESS_SPACE_IOCTL_DEALLOCATE_BLOCK => {
+                let mut reader = UserSlice::new(UserPtr::from_addr(arg), size_of::<u64>()).reader();
+                device.deallocate_block(reader.read::<u64>()?)?;
+                Ok(0)
+            }
+            GOLDFISH_ADDRESS_SPACE_IOCTL_PING => {
+                let data = UserSlice::new(UserPtr::from_addr(arg), PingIoctl::ENCODED_LEN);
+                let (mut reader, mut writer) = data.reader_writer();
+                let mut bytes = [0u8; PingIoctl::ENCODED_LEN];
+                reader.read_slice(&mut bytes)?;
+                let request = PingIoctl::decode(&bytes);
+                let response = device.ping(request)?;
+                writer.write_slice(&response.encode())?;
+                Ok(0)
+            }
+            GOLDFISH_ADDRESS_SPACE_IOCTL_CLAIM_SHARED => {
+                let data = UserSlice::new(UserPtr::from_addr(arg), ClaimSharedIoctl::ENCODED_LEN);
+                let (mut reader, mut writer) = data.reader_writer();
+                let mut bytes = [0u8; ClaimSharedIoctl::ENCODED_LEN];
+                reader.read_slice(&mut bytes)?;
+                let request = ClaimSharedIoctl::decode(&bytes);
+                let response = device.claim_shared(request)?;
+                writer.write_slice(&response.encode())?;
+                Ok(0)
+            }
+            GOLDFISH_ADDRESS_SPACE_IOCTL_UNCLAIM_SHARED => {
+                let mut reader = UserSlice::new(UserPtr::from_addr(arg), size_of::<u64>()).reader();
+                device.unclaim_shared(reader.read::<u64>()?)?;
+                Ok(0)
+            }
+            _ => Err(ENOTTY),
+        }
+    }
+
+    #[cfg(CONFIG_COMPAT)]
+    fn compat_ioctl(
+        device: ArcBorrow<'_, FileState>,
+        file: &File,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize> {
+        Self::ioctl(device, file, cmd, arg)
+    }
+}
+
+kernel::declare_misc_device_fops!(GoldfishAddressSpaceMisc);
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <GoldfishAddressSpaceDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(
+            pci::Vendor::from_raw(GOLDFISH_AS_VENDOR_ID as u16),
+            GOLDFISH_AS_DEVICE_ID,
+        ),
+        (),
+    )]
+);
+
+impl pci::Driver for GoldfishAddressSpaceDriver {
+    type IdInfo = ();
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &pci::Device<Core>, _id_info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+        pin_init::pin_init_scope(move || {
+            if pdev.revision_id() != GOLDFISH_AS_SUPPORTED_REVISION {
+                return Err(ENODEV);
+            }
+
+            pdev.enable_device_mem()?;
+            let enable_guard = ScopeGuard::new(|| pdev.disable_device());
+
+            let runtime = DeviceRuntime::new(pdev)?;
+            runtime.program_host_visible_state()?;
+
+            let driver = try_pin_init!(Self {
+                runtime: runtime.clone(),
+                misc <- MiscDeviceRegistration::register_with_data(
+                    MiscDeviceOptions {
+                        name: c"goldfish_address_space",
+                    },
+                    runtime.clone(),
+                ),
+            });
+            enable_guard.dismiss();
+
+            Ok(driver)
+        })
+    }
+
+    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+        let this = this.get_ref();
+        // 1. Stop new miscdevice opens from reaching the driver.
+        this.misc.deregister();
+        // 2. Wait for already-running syscalls, then revoke every still-live file's device-side
+        //    state before the PCI function disappears.
+        this.runtime.shutdown();
+        // 3. Only then disable the PCI function, so post-shutdown release never needs to touch a
+        //    disabled device.
+        pdev.disable_device();
+    }
+}
+
+kernel::module_pci_driver! {
+    type: GoldfishAddressSpaceDriver,
+    name: "goldfish_address_space",
+    authors: ["Wenzhao Liao"],
+    description: "Rust Goldfish address space driver",
+    license: "GPL v2",
+}
-- 
2.34.1


