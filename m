Return-Path: <linux-api+bounces-1543-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D38C9666
	for <lists+linux-api@lfdr.de>; Sun, 19 May 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FEFEB20D79
	for <lists+linux-api@lfdr.de>; Sun, 19 May 2024 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8B770EA;
	Sun, 19 May 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="bAZOkDQM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3550276;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150319; cv=none; b=JEY+QovF5cOwOkgDj7soF0Jj9lBg14oIzBbOXig2jAgCIxd8gRGVbeqUb5xOjMxph+SyzGAr3ufgcBZq38FHeJQbdZT7c4JpCWLYQnXR4O6a26ucxVpDcZjkbfin+pdAiBShGwOrpRCn+zVMhYfK6UGyql3DXW66XsuBQvtGdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150319; c=relaxed/simple;
	bh=c+6U+ZbefTz0YtyUBcA/usnu8kiO48W/n5csRaPODMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsJM0yE0ptd+SFtzNslhIOs+B6QpZrKG6asml0cmC86VKy553x2jvHkTzQKoXrmH/QQJhzKVlG9n5w6BNPogqJv7rl2Lu80lbCk1j/SxAkxiOKMbm9rBBJphaQKKL7z8wLdi3LD/glyPeKjujcmkXnHtPprETPoKj4YGSp8A7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=bAZOkDQM; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=S+Bo60slTZYs+MASNA28omTt/46YdAeLaNdjfMjNW6Q=; b=bAZOkDQM+nPjsLVKd9gKtk1PK1
	Mp2Zm3g43lxLtfqH+NIQ6BpdXPEjphFVAbLqHPufHyZq7HK/gCijuMmVRVsUapXEegbUlIqqlKErC
	QwdvRVTZFPXVZAegUgUCoF5swejzTb+SRk2boVmcf+aGZosUq4R9b8NKqIeVDLQ7MNFk/y9aHKEwP
	uJWY5BakZq1sHLiaZwrwq+pZs0hHwe2Mb5KdnVTLf5HkS78raXq3Jj8B35NdwcKCD/L5YbbYSjFMe
	miSeRbyizd57xuoOyGCmngBXeVwIpKE0LwyUuzI5xeVuYdpfSQKC2K2ROZw3PmTFUHjXXG6LAxdYk
	CS6lATKA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5e-008wIn-0Z;
	Sun, 19 May 2024 15:25:06 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v5 17/28] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ALL.
Date: Sun, 19 May 2024 15:24:43 -0500
Message-ID: <20240519202454.1192826-18-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ALL, and when objects
are considered simultaneously signaled.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 99 ++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 40ad8cbd3138..c0f372167557 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -73,7 +73,8 @@ static int unlock_mutex(int mutex, __u32 owner, __u32 *count)
 	return ret;
 }
 
-static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+static int wait_objs(int fd, unsigned long request, __u32 count,
+		     const int *objs, __u32 owner, __u32 *index)
 {
 	struct ntsync_wait_args args = {0};
 	struct timespec timeout;
@@ -86,11 +87,21 @@ static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *in
 	args.objs = (uintptr_t)objs;
 	args.owner = owner;
 	args.index = 0xdeadbeef;
-	ret = ioctl(fd, NTSYNC_IOC_WAIT_ANY, &args);
+	ret = ioctl(fd, request, &args);
 	*index = args.index;
 	return ret;
 }
 
+static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ANY, count, objs, owner, index);
+}
+
+static int wait_all(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
+{
+	return wait_objs(fd, NTSYNC_IOC_WAIT_ALL, count, objs, owner, index);
+}
+
 TEST(semaphore_state)
 {
 	struct ntsync_sem_args sem_args;
@@ -461,4 +472,88 @@ TEST(test_wait_any)
 	close(fd);
 }
 
+TEST(test_wait_all)
+{
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 owner, index, count;
+	int objs[2], fd, ret;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 2;
+	sem_args.max = 3;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+
+	objs[0] = sem_args.sem;
+	objs[1] = mutex_args.mutex;
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_all(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	count = 3;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 2, 3);
+	check_mutex_state(mutex_args.mutex, 3, 123);
+
+	owner = 123;
+	ret = ioctl(mutex_args.mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	/* test waiting on the same object twice */
+	objs[0] = objs[1] = sem_args.sem;
+	ret = wait_all(fd, 2, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	close(sem_args.sem);
+	close(mutex_args.mutex);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


