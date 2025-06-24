Return-Path: <linux-api+bounces-3981-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C4AE6E4B
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DB83A0676
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9262F0C7C;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dINPAu4N"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874D2F0C57;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788478; cv=none; b=AelKRmSRUDk5vRKzmn+G38+15BIaVU0IWp/8JM8tEsWWItfPHbtn9p+xAZhh2nEqGs5IgaCLH5WHPb+pmHoAt+7cBSqepa8NmJiM/UfwEVZ8aSDtDXTMfkViNR3p1ucbI6SpWkdKxOQKMBkIusDnjZAFdpLlquGkHfcbDYoTDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788478; c=relaxed/simple;
	bh=HxtRmwoDN4cS08ebLTAEw2XokEa0cnlqfNYikMQE++A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3FGckjlmmBKKYM/P80NrS+TIEvmZ9QeXQMeVIZLgrMukB3XfU/8ejYhm9Y+5XRlBGfgLYHbvUqBw9NvRk5Ywdl6xciLPtIbEfRN+l/KFTJM6KJzHj7177l+Gtilqw7p7VRzfyy/20bMiA7p7h5w0B+A9etoyHJK302RJVHcv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dINPAu4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916FFC4CEF3;
	Tue, 24 Jun 2025 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788477;
	bh=HxtRmwoDN4cS08ebLTAEw2XokEa0cnlqfNYikMQE++A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dINPAu4N/4PjZNdLJJhrtDN/6Z9d1qrMudgqanq744VWokHK1n/hJ5DGoMWIafE2Y
	 V356IA7FkgiMN8a8yCmy56a+GRqoj02XXyLdPTdVfPqjUTuRuwiGc/m5/af3ObRPF2
	 8k1tHoE7goRVpFdU/bn3FtrY7lWK3n1k47X9dpCWbSUJ5wIgdj8+MGncWoP6OZ0v9n
	 6UVxFCmdT576cBLNdYHmutYLHOqqt+5ViL/+2Bssimd+++fc93wtmg7Wh04BNXVhb6
	 6i6FuDye80+RwBPZxjSJgIF05NM5NNsz2suoR1VGFWH4whlEjvOULKiu1mQM1z8SVF
	 vhD/20DTwDmLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 20/22] block: sysfs API specifications
Date: Tue, 24 Jun 2025 14:07:40 -0400
Message-Id: <20250624180742.5795-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation to block sysfs specifications.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-integrity.c | 131 +++++++++++++++++++++++
 block/blk-sysfs.c     | 243 ++++++++++++++++++++++++++++++++++++++++++
 block/genhd.c         |  99 +++++++++++++++++
 3 files changed, 473 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e4e2567061f9d..bfe08c8fab91b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -13,6 +13,8 @@
 #include <linux/scatterlist.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/syscall_api_spec.h>
 
 #include "blk.h"
 
@@ -234,6 +236,29 @@ static ssize_t flag_show(struct device *dev, char *page, unsigned char flag)
 	return sysfs_emit(page, "%d\n", !(bi->flags & flag));
 }
 
+/*
+ * Sysfs API specifications for integrity attributes
+ */
+DEFINE_SYSFS_API_SPEC(format)
+	KAPI_DESCRIPTION("Metadata format for integrity")
+	KAPI_LONG_DESC("Metadata format for integrity capable block device. "
+		       "E.g. T10-DIF-TYPE1-CRC. This field describes the type of T10 "
+		       "Protection Information that the block device can send and receive. "
+		       "If the device can store application integrity metadata but "
+		       "no T10 Protection Information profile is used, this field "
+		       "contains 'nop'. If the device does not support integrity "
+		       "metadata, this field contains 'none'.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "format", "string", "Integrity metadata format")
+		KAPI_PARAM_TYPE(KAPI_TYPE_STRING)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/integrity/format")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/integrity/format")
+KAPI_END_SPEC;
+
 static ssize_t format_show(struct device *dev, struct device_attribute *attr,
 			   char *page)
 {
@@ -244,6 +269,33 @@ static ssize_t format_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(page, "%s\n", blk_integrity_profile_name(bi));
 }
 
+DEFINE_SYSFS_API_SPEC(tag_size)
+	KAPI_DESCRIPTION("Integrity tag size")
+	KAPI_LONG_DESC("Number of bytes of integrity tag space available per "
+		       "protection_interval_bytes, which is typically "
+		       "the device's logical block size. "
+		       "This field describes the size of the application tag "
+		       "if the storage device is formatted with T10 Protection "
+		       "Information and permits use of the application tag.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "tag_size", "unsigned int", "Tag size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/integrity/tag_size")
+		KAPI_PARAM_RANGE(0, 65535)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/integrity/tag_size")
+	KAPI_NOTES("If the device does not support T10 Protection Information (even if the "
+		   "device provides application integrity metadata space), this field is set to 0. "
+		   "The owner of this tag space is the owner of the block device. The filesystem "
+		   "can use this extra space to tag sectors as they see fit. Because the tag space "
+		   "is limited, the block interface allows tagging bigger chunks by way of interleaving. "
+		   "This way, 8*16 bits of information can be attached to a typical 4KB filesystem block.")
+KAPI_END_SPEC;
+
 static ssize_t tag_size_show(struct device *dev, struct device_attribute *attr,
 			     char *page)
 {
@@ -252,6 +304,26 @@ static ssize_t tag_size_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(page, "%u\n", bi->tag_size);
 }
 
+DEFINE_SYSFS_API_SPEC(protection_interval_bytes)
+	KAPI_DESCRIPTION("Protection interval size")
+	KAPI_LONG_DESC("Describes the number of data bytes which are protected by one "
+		       "integrity tuple. Typically the device's logical block size. "
+		       "For example, a 512-byte sector with 8-byte integrity metadata "
+		       "would have a protection interval of 512 bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "protection_interval_bytes", "unsigned int", "Protection interval in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/integrity/protection_interval_bytes")
+		KAPI_PARAM_RANGE(0, 65536)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/integrity/protection_interval_bytes")
+	KAPI_NOTES("This is typically the same as the device's logical block size")
+KAPI_END_SPEC;
+
 static ssize_t protection_interval_bytes_show(struct device *dev,
 					      struct device_attribute *attr,
 					      char *page)
@@ -275,6 +347,25 @@ static ssize_t read_verify_show(struct device *dev,
 	return flag_show(dev, page, BLK_INTEGRITY_NOVERIFY);
 }
 
+DEFINE_SYSFS_API_SPEC(read_verify)
+	KAPI_DESCRIPTION("Read request integrity verification")
+	KAPI_LONG_DESC("Indicates whether the block layer should verify the integrity "
+		       "of read requests serviced by devices that support sending "
+		       "integrity metadata. A value of 1 enables verification, while "
+		       "0 disables it. When enabled, the block layer will check "
+		       "integrity metadata on read operations.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "read_verify", "bool", "Enable read integrity verification")
+		KAPI_PARAM_TYPE(KAPI_TYPE_BOOL)
+		KAPI_PERMISSIONS(0644)
+		KAPI_PATH("/sys/block/<disk>/integrity/read_verify")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_RW)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("echo 1 > /sys/block/sda/integrity/read_verify")
+	KAPI_NOTES("This attribute only has effect if the device supports integrity metadata")
+KAPI_END_SPEC;
+
 static ssize_t write_generate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *page, size_t count)
@@ -288,6 +379,46 @@ static ssize_t write_generate_show(struct device *dev,
 	return flag_show(dev, page, BLK_INTEGRITY_NOGENERATE);
 }
 
+DEFINE_SYSFS_API_SPEC(write_generate)
+	KAPI_DESCRIPTION("Write request integrity generation")
+	KAPI_LONG_DESC("Indicates whether the block layer should automatically generate "
+		       "checksums for write requests bound for devices that support "
+		       "receiving integrity metadata. A value of 1 enables generation, "
+		       "while 0 disables it. When enabled, the block layer will compute "
+		       "and attach integrity metadata to write operations.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "write_generate", "bool", "Enable write integrity generation")
+		KAPI_PARAM_TYPE(KAPI_TYPE_BOOL)
+		KAPI_PERMISSIONS(0644)
+		KAPI_PATH("/sys/block/<disk>/integrity/write_generate")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_RW)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("echo 1 > /sys/block/sda/integrity/write_generate")
+	KAPI_NOTES("This attribute only has effect if the device supports integrity metadata")
+KAPI_END_SPEC;
+
+DEFINE_SYSFS_API_SPEC(device_is_integrity_capable)
+	KAPI_DESCRIPTION("Device integrity capability")
+	KAPI_LONG_DESC("Indicates whether a storage device is capable of storing "
+		       "integrity metadata. Set if the device is T10 PI-capable. "
+		       "This flag is set to 1 if the storage media is formatted "
+		       "with T10 Protection Information. If the storage media is "
+		       "not formatted with T10 Protection Information, this flag "
+		       "is set to 0. This is a key indicator for whether the device "
+		       "supports end-to-end data protection using standards like "
+		       "T10 DIF (Data Integrity Field) for SCSI devices.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "device_is_integrity_capable", "bool", "Device integrity capability flag")
+		KAPI_PARAM_TYPE(KAPI_TYPE_BOOL)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/integrity/device_is_integrity_capable")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/integrity/device_is_integrity_capable")
+KAPI_END_SPEC;
+
 static ssize_t device_is_integrity_capable_show(struct device *dev,
 						struct device_attribute *attr,
 						char *page)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967c..8446ed4fc63d8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -10,6 +10,8 @@
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
 #include <linux/debugfs.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/syscall_api_spec.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -51,6 +53,31 @@ queue_var_store(unsigned long *var, const char *page, size_t count)
 	return count;
 }
 
+DEFINE_SYSFS_API_SPEC(nr_requests)
+	KAPI_DESCRIPTION("Number of allocatable requests")
+	KAPI_LONG_DESC("This controls how many requests may be allocated in the "
+		       "block layer for read or write requests. Note that the total "
+		       "allocated number may be twice this amount, since it applies only "
+		       "to reads or writes (not the accumulated sum). "
+		       "When CONFIG_BLK_CGROUP is enabled, each request queue may have "
+		       "up to N request pools for N block cgroups.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "nr_requests", "unsigned int", "Number of allocatable requests")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0644)
+		KAPI_PATH("/sys/block/<disk>/queue/nr_requests")
+		KAPI_PARAM_RANGE(BLKDEV_MIN_RQ, INT_MAX)
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_RW)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("echo 256 > /sys/block/sda/queue/nr_requests")
+	KAPI_NOTES("To avoid priority inversion through request starvation, a request queue "
+		   "maintains a separate request pool per each cgroup when CONFIG_BLK_CGROUP "
+		   "is enabled, and this parameter applies to each such per-block-cgroup "
+		   "request pool. IOW, if there are N block cgroups, each request queue may "
+		   "have up to N request pools, each independently regulated by nr_requests.")
+KAPI_END_SPEC;
+
 static ssize_t queue_requests_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
@@ -89,6 +116,29 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+DEFINE_SYSFS_API_SPEC(read_ahead_kb)
+	KAPI_DESCRIPTION("Read-ahead size")
+	KAPI_LONG_DESC("Maximum number of kilobytes to read-ahead for filesystems "
+		       "on this block device. For MADV_HUGEPAGE, the readahead size "
+		       "may exceed this setting since its granularity is based on the "
+		       "hugepage size.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "read_ahead_kb", "unsigned int", "Read-ahead size in kilobytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0644)
+		KAPI_PATH("/sys/block/<disk>/queue/read_ahead_kb")
+		KAPI_PARAM_RANGE(0, ULONG_MAX >> (PAGE_SHIFT - 10))
+		KAPI_UNITS("kilobytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_RW)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("echo 128 > /sys/block/sda/queue/read_ahead_kb")
+	KAPI_NOTES("128 KB for each device is a good starting point, but increasing to "
+		   "4-8 MB might improve performance in environments where sequential "
+		   "reading of large files takes place. Changes are not persistent "
+		   "across reboots unless saved in startup scripts.")
+KAPI_END_SPEC;
+
 static ssize_t queue_ra_show(struct gendisk *disk, char *page)
 {
 	ssize_t ret;
@@ -124,6 +174,62 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
 	return ret;
 }
 
+/*
+ * Sysfs API specifications for queue attributes
+ */
+DEFINE_SYSFS_API_SPEC(logical_block_size)
+	KAPI_DESCRIPTION("Logical block size")
+	KAPI_LONG_DESC("This is the smallest unit the storage device can address. "
+		       "It is typically 512 bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "logical_block_size", "unsigned int", "Logical block size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PATH("/sys/block/<disk>/queue/logical_block_size")
+		KAPI_PERMISSIONS(0444)
+		KAPI_PARAM_RANGE(512, 4096)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/queue/logical_block_size")
+KAPI_END_SPEC;
+
+DEFINE_SYSFS_API_SPEC(physical_block_size)
+	KAPI_DESCRIPTION("Physical block size")
+	KAPI_LONG_DESC("This is the smallest unit a physical storage device can "
+		       "write atomically. It is usually the same as the logical block "
+		       "size but may be bigger. One example is SATA drives with 4KB "
+		       "sectors that expose a 512-byte logical block size to the "
+		       "operating system.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "physical_block_size", "unsigned int", "Physical block size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/physical_block_size")
+		KAPI_PARAM_RANGE(512, 4194304)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/queue/physical_block_size")
+KAPI_END_SPEC;
+
+DEFINE_SYSFS_API_SPEC(hw_sector_size)
+	KAPI_DESCRIPTION("Hardware sector size")
+	KAPI_LONG_DESC("This is the hardware sector size of the device, in bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "hw_sector_size", "unsigned int", "Hardware sector size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/hw_sector_size")
+		KAPI_PARAM_RANGE(512, 4194304)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/queue/hw_sector_size")
+KAPI_END_SPEC;
+
 #define QUEUE_SYSFS_LIMIT_SHOW(_field)					\
 static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 {									\
@@ -147,7 +253,53 @@ QUEUE_SYSFS_LIMIT_SHOW(virt_boundary_mask)
 QUEUE_SYSFS_LIMIT_SHOW(dma_alignment)
 QUEUE_SYSFS_LIMIT_SHOW(max_open_zones)
 QUEUE_SYSFS_LIMIT_SHOW(max_active_zones)
+DEFINE_SYSFS_API_SPEC(atomic_write_unit_min_bytes)
+	KAPI_DESCRIPTION("Minimum atomic write unit size")
+	KAPI_LONG_DESC("This parameter specifies the smallest block which can "
+		       "be written atomically with an atomic write operation. All "
+		       "atomic write operations must begin at a "
+		       "atomic_write_unit_min boundary and must be multiples of "
+		       "atomic_write_unit_min. This value must be a power-of-two.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "atomic_write_unit_min_bytes", "unsigned int", "Minimum atomic write unit size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/atomic_write_unit_min_bytes")
+		KAPI_PARAM_RANGE(0, ULLONG_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/nvme0n1/queue/atomic_write_unit_min_bytes")
+	KAPI_NOTES("This value must be a power-of-two. All atomic write operations must "
+		   "begin at a atomic_write_unit_min boundary and must be multiples of "
+		   "atomic_write_unit_min.")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_min)
+
+DEFINE_SYSFS_API_SPEC(atomic_write_unit_max_bytes)
+	KAPI_DESCRIPTION("Maximum atomic write unit size")
+	KAPI_LONG_DESC("This parameter defines the largest block which can be "
+		       "written atomically with an atomic write operation. This "
+		       "value must be a multiple of atomic_write_unit_min and must "
+		       "be a power-of-two. This value will not be larger than "
+		       "atomic_write_max_bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "atomic_write_unit_max_bytes", "unsigned int", "Maximum atomic write unit size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/atomic_write_unit_max_bytes")
+		KAPI_PARAM_RANGE(0, ULLONG_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/nvme0n1/queue/atomic_write_unit_max_bytes")
+	KAPI_NOTES("This value must be a multiple of atomic_write_unit_min and must be a "
+		   "power-of-two. This value will not be larger than atomic_write_max_bytes.")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW(atomic_write_unit_max)
 
 #define QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(_field)			\
@@ -161,7 +313,60 @@ static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_write_zeroes_sectors)
+
+DEFINE_SYSFS_API_SPEC(atomic_write_max_bytes)
+	KAPI_DESCRIPTION("Maximum atomic write size")
+	KAPI_LONG_DESC("This parameter specifies the maximum atomic write "
+		       "size reported by the device. This parameter is relevant "
+		       "for merging of writes, where a merged atomic write "
+		       "operation must not exceed this number of bytes. "
+		       "This parameter may be greater than atomic_write_unit_max_bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "atomic_write_max_bytes", "unsigned int", "Maximum atomic write size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/atomic_write_max_bytes")
+		KAPI_PARAM_RANGE(0, ULLONG_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/nvme0n1/queue/atomic_write_max_bytes")
+	KAPI_NOTES("This parameter is relevant for merging of writes, where a merged atomic "
+		   "write operation must not exceed this number of bytes. May be greater than "
+		   "atomic_write_unit_max_bytes as atomic_write_unit_max_bytes will be rounded "
+		   "down to a power-of-two and may also be limited by other queue limits such "
+		   "as max_segments. Will not be larger than max_hw_sectors_kb.")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
+
+DEFINE_SYSFS_API_SPEC(atomic_write_boundary_bytes)
+	KAPI_DESCRIPTION("Atomic write boundary size")
+	KAPI_LONG_DESC("A device may need to internally split an atomic write I/O "
+		       "which straddles a given logical block address boundary. This "
+		       "parameter specifies the size in bytes of the atomic boundary if "
+		       "one is reported by the device. This value must be a "
+		       "power-of-two and at least the size as in "
+		       "atomic_write_unit_max_bytes.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "atomic_write_boundary_bytes", "unsigned int", "Atomic write boundary size in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/atomic_write_boundary_bytes")
+		KAPI_PARAM_RANGE(0, ULLONG_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/nvme0n1/queue/atomic_write_boundary_bytes")
+	KAPI_NOTES("A device may need to internally split an atomic write I/O which straddles "
+		   "a given logical block address boundary. This specifies the size in bytes of "
+		   "the atomic boundary if one is reported by the device. Must be a power-of-two "
+		   "and at least the size as in atomic_write_unit_max_bytes. Any attempt to merge "
+		   "atomic write I/Os must not result in a merged I/O which crosses this boundary.")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_zone_append_sectors)
 
@@ -171,7 +376,45 @@ static ssize_t queue_##_field##_show(struct gendisk *disk, char *page)	\
 	return queue_var_show(disk->queue->limits._field >> 1, page);	\
 }
 
+DEFINE_SYSFS_API_SPEC(max_sectors_kb)
+	KAPI_DESCRIPTION("Maximum request size (software limit)")
+	KAPI_LONG_DESC("This is the maximum number of kilobytes that the block "
+		       "layer will allow for a filesystem request. Must be smaller than "
+		       "or equal to the maximum size allowed by the hardware. Write 0 "
+		       "to use default kernel settings.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "max_sectors_kb", "unsigned int", "Maximum request size in kilobytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0644)
+		KAPI_PATH("/sys/block/<disk>/queue/max_sectors_kb")
+		KAPI_PARAM_RANGE(0, UINT_MAX)
+		KAPI_UNITS("kilobytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_RW)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("echo 512 > /sys/block/sda/queue/max_sectors_kb")
+	KAPI_NOTES("Must be <= max_hw_sectors_kb")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_sectors)
+
+DEFINE_SYSFS_API_SPEC(max_hw_sectors_kb)
+	KAPI_DESCRIPTION("Maximum request size (hardware limit)")
+	KAPI_LONG_DESC("This is the maximum number of kilobytes supported in a "
+		       "single data transfer.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "max_hw_sectors_kb", "unsigned int", "Maximum hardware request size in kilobytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/queue/max_hw_sectors_kb")
+		KAPI_PARAM_RANGE(0, UINT_MAX)
+		KAPI_UNITS("kilobytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/queue/max_hw_sectors_kb")
+KAPI_END_SPEC;
+
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_KB(max_hw_sectors)
 
 #define QUEUE_SYSFS_SHOW_CONST(_name, _val)				\
diff --git a/block/genhd.c b/block/genhd.c
index 8171a6bc3210f..3cbc5418825f0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -26,6 +26,8 @@
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
 #include <linux/blktrace_api.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/syscall_api_spec.h>
 
 #include "blk-throttle.h"
 #include "blk.h"
@@ -1104,6 +1106,25 @@ ssize_t part_stat_show(struct device *dev,
  * For bio-based device, started from bdev_start_io_acct();
  * For rq-based device, started from blk_mq_start_request();
  */
+DEFINE_SYSFS_API_SPEC(inflight)
+	KAPI_DESCRIPTION("I/O requests in progress")
+	KAPI_LONG_DESC("Reports the number of I/O requests currently in progress "
+		       "(pending / in flight) in a device driver. This can be less "
+		       "than the number of requests queued in the block device queue. "
+		       "The report contains 2 fields: one for read requests "
+		       "and one for write requests.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "inflight", "string", "Two unsigned integers: read and write requests in flight")
+		KAPI_PARAM_TYPE(KAPI_TYPE_STRING)
+		KAPI_PATH("/sys/block/<disk>/inflight")
+		KAPI_PERMISSIONS(0444)
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/inflight")
+	KAPI_NOTES("The value type is unsigned int. Related to /sys/block/<disk>/queue/nr_requests")
+KAPI_END_SPEC;
+
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -1123,6 +1144,28 @@ static ssize_t disk_capability_show(struct device *dev,
 	return sysfs_emit(buf, "0\n");
 }
 
+/*
+ * Sysfs API specifications for disk attributes
+ */
+DEFINE_SYSFS_API_SPEC(alignment_offset)
+	KAPI_DESCRIPTION("Physical block alignment offset")
+	KAPI_LONG_DESC("Storage devices may report a physical block size that is "
+		       "bigger than the logical block size. This parameter "
+		       "indicates how many bytes the beginning of the device is "
+		       "offset from the disk's natural alignment.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "alignment_offset", "int", "Alignment offset in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PATH("/sys/block/<disk>/alignment_offset")
+		KAPI_PERMISSIONS(0444)
+		KAPI_PARAM_RANGE(0, INT_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/alignment_offset")
+KAPI_END_SPEC;
+
 static ssize_t disk_alignment_offset_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -1132,6 +1175,27 @@ static ssize_t disk_alignment_offset_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
+DEFINE_SYSFS_API_SPEC(discard_alignment)
+	KAPI_DESCRIPTION("Discard alignment offset")
+	KAPI_LONG_DESC("Devices that support discard functionality may "
+		       "internally allocate space in units that are bigger than "
+		       "the exported logical block size. The discard_alignment "
+		       "parameter indicates how many bytes the beginning of the "
+		       "device is offset from the internal allocation unit's "
+		       "natural alignment.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "discard_alignment", "int", "Discard alignment offset in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PATH("/sys/block/<disk>/discard_alignment")
+		KAPI_PERMISSIONS(0444)
+		KAPI_PARAM_RANGE(0, INT_MAX)
+		KAPI_UNITS("bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/discard_alignment")
+KAPI_END_SPEC;
+
 static ssize_t disk_discard_alignment_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
@@ -1141,6 +1205,25 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
+DEFINE_SYSFS_API_SPEC(diskseq)
+	KAPI_DESCRIPTION("Disk sequence number")
+	KAPI_LONG_DESC("The diskseq attribute reports the disk sequence number, "
+		       "which is a monotonically increasing number assigned to "
+		       "every drive. Some devices, like the loop device, refresh "
+		       "this number every time the backing file is changed.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "diskseq", "uint64_t", "64-bit disk sequence number")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/diskseq")
+		KAPI_PARAM_RANGE(0, ULLONG_MAX)
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/diskseq")
+	KAPI_NOTES("Value type is 64 bit unsigned")
+KAPI_END_SPEC;
+
 static ssize_t diskseq_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1149,6 +1232,22 @@ static ssize_t diskseq_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", disk->diskseq);
 }
 
+DEFINE_SYSFS_API_SPEC(partscan)
+	KAPI_DESCRIPTION("Partition scanning status")
+	KAPI_LONG_DESC("Reports if partition scanning is enabled for the disk. "
+		       "Returns '1' if partition scanning is enabled, or '0' if not.")
+	KAPI_PARAM_COUNT(1)
+	KAPI_PARAM(0, "partscan", "bool", "Partition scanning enabled flag")
+		KAPI_PARAM_TYPE(KAPI_TYPE_BOOL)
+		KAPI_PERMISSIONS(0444)
+		KAPI_PATH("/sys/block/<disk>/partscan")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_SYSFS_READONLY)
+	KAPI_PARAM_END
+	KAPI_SUBSYSTEM("block")
+	KAPI_EXAMPLES("cat /sys/block/sda/partscan")
+	KAPI_NOTES("The value type is a 32-bit unsigned integer, but only '0' and '1' are valid values")
+KAPI_END_SPEC;
+
 static ssize_t partscan_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-- 
2.39.5


