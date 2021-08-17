Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78C3EF49F
	for <lists+linux-api@lfdr.de>; Tue, 17 Aug 2021 23:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhHQVIc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Aug 2021 17:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhHQVIX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Aug 2021 17:08:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106AC061764
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so453771plr.12
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYtoRNz68jQwYvjBX4U7IVcrSjuz98N2fJHJaXMVFi0=;
        b=gZFbABnV7u0+5S5XKSVcj+L7QRsFXJFjDkLDvsgrIHZSAgs414Kk2f3YdJHac0As/+
         23Cxrez4+1s/XwwCb9fpfxEesl0siCiTMw0azi2Rgh5sBeqAAALHABQNLU6n5xNMrcAw
         zu0xJjOOZNMCZMGlI49MNCfZRQscRys0i6XXOxy7fE5CM1ni7IejwEQZirFhru94OvdZ
         gOnwAYGxEKeysGLDN+wqCvdigJFB8PXOzcpnANEvXEW4J+FfFRpkRRT+0p+HyGLTZCud
         0JtrB1H6sJFcgueReuOFP5hDLspQyEv77Na7/XaND83yZBntql50IpVQ3kAym7B1Y2RL
         dv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYtoRNz68jQwYvjBX4U7IVcrSjuz98N2fJHJaXMVFi0=;
        b=o1IDhyWtdP/HkWLHxrT+zKUwszjHCrs1+NsuR2eEyaQQ3MeZrRUw8cF350LTsLbFep
         Dbp8QPJHgEfOGwQpbGLuuxkr9sJTdMuDfgQ6cyAdAkRKCHG94XnnLmRTPJYX0S3Jn5sH
         275ZLetshEJj6RNaxloLGLl41kpO5FfWRGIFc7nhj+eYArZTZDusS4IXt8du/ShPGIv4
         OzheFo1G1l0Cgrj6AKdyxYzGD1f/hRGEr90mTjl++EwbqiC0hCAYFg/GWJQHnd6m38w6
         D2vwnFlAvc8w5UdPF0Mzjyb2zE0q0tS8YDN9qXU9SLVHasVHvE3Jqzsdd6STHjOz6zYV
         fbjw==
X-Gm-Message-State: AOAM530LX05kF6rT8qLFaOzgZfDF/03vdHmQMmJhOafiodl//gbykX7x
        NwvRieGwVy+DYAq0O4BUMeZmOhq22Bc3yA==
X-Google-Smtp-Source: ABdhPJy/IM3T0gGESIaXF9Gpi7uqzvW4HEfalyS6eiPXc4vnDdTUHV/iMqxEt3bdfFlHV1Q4eHp93w==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr5693384pjb.174.1629234469157;
        Tue, 17 Aug 2021 14:07:49 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:48 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 10/10] btrfs-progs: receive: add tests for basic encoded_write send/receive
Date:   Tue, 17 Aug 2021 14:06:56 -0700
Message-Id: <28e081a6c29468a127fcf9edf936005a3810d2b2.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Adapt the existing send/receive tests by passing '-o --force-compress'
to the mount commands in a new test. After writing a few files in the
various compression formats, send/receive them with and without
--force-decompress to test both the encoded_write path and the
fallback to decode+write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 .../049-receive-write-encoded/test.sh         | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tests/misc-tests/049-receive-write-encoded/test.sh

diff --git a/tests/misc-tests/049-receive-write-encoded/test.sh b/tests/misc-tests/049-receive-write-encoded/test.sh
new file mode 100755
index 00000000..b9390e88
--- /dev/null
+++ b/tests/misc-tests/049-receive-write-encoded/test.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+#
+# test that we can send and receive encoded writes for three modes of
+# transparent compression: zlib, lzo, and zstd.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+here=`pwd`
+
+# assumes the filesystem exists, and does mount, write, snapshot, send, unmount
+# for the specified encoding option
+send_one() {
+	local str
+	local subv
+	local snap
+
+	algorithm="$1"
+	shift
+	str="$1"
+	shift
+
+	subv="subv-$algorithm"
+	snap="snap-$algorithm"
+
+	run_check_mount_test_dev "-o" "compress-force=$algorithm"
+	cd "$TEST_MNT" || _fail "cannot chdir to TEST_MNT"
+
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$subv"
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file1" bs=1M count=1
+	run_check $SUDO_HELPER dd if=/dev/zero of="$subv/file2" bs=500K count=1
+	run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$subv" "$snap"
+	run_check $SUDO_HELPER "$TOP/btrfs" send -f "$str" "$snap" "$@"
+
+	cd "$here" || _fail "cannot chdir back to test directory"
+	run_check_umount_test_dev
+}
+
+receive_one() {
+	local str
+	str="$1"
+	shift
+
+	run_check_mkfs_test_dev
+	run_check_mount_test_dev
+	run_check $SUDO_HELPER "$TOP/btrfs" receive "$@" -v -f "$str" "$TEST_MNT"
+	run_check_umount_test_dev
+	run_check rm -f -- "$str"
+}
+
+test_one_write_encoded() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --compressed-data
+	receive_one "$str" "$@"
+}
+
+test_one_stream_v1() {
+	local str
+	local algorithm
+	algorithm="$1"
+	shift
+	str="$here/stream-$algorithm.stream"
+
+	run_check_mkfs_test_dev
+	send_one "$algorithm" "$str" --stream-version 1
+	receive_one "$str" "$@"
+}
+
+test_mix_write_encoded() {
+	local strzlib
+	local strlzo
+	local strzstd
+	strzlib="$here/stream-zlib.stream"
+	strlzo="$here/stream-lzo.stream"
+	strzstd="$here/stream-zstd.stream"
+
+	run_check_mkfs_test_dev
+
+	send_one "zlib" "$strzlib" --compressed-data
+	send_one "lzo" "$strlzo" --compressed-data
+	send_one "zstd" "$strzstd" --compressed-data
+
+	receive_one "$strzlib"
+	receive_one "$strlzo"
+	receive_one "$strzstd"
+}
+
+test_one_write_encoded "zlib"
+test_one_write_encoded "lzo"
+test_one_write_encoded "zstd"
+
+# with decompression forced
+test_one_write_encoded "zlib" "--force-decompress"
+test_one_write_encoded "lzo" "--force-decompress"
+test_one_write_encoded "zstd" "--force-decompress"
+
+# send stream v1
+test_one_stream_v1 "zlib"
+test_one_stream_v1 "lzo"
+test_one_stream_v1 "zstd"
+
+# files use a mix of compression algorithms
+test_mix_write_encoded
-- 
2.32.0

