Return-Path: <linux-api+bounces-2865-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310EA9E9F02
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 20:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D6B1681BC
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41119B5BE;
	Mon,  9 Dec 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="nDzW5UBF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13019ABC6;
	Mon,  9 Dec 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770975; cv=none; b=SzSBvh55RFt/Fhj7iW+R97EbSDj1T9q9NGT+nrCmbY9mkXoG56TMiZmCpq/IQAYlWGGMKEEhj2mSCmS5E+/oWdnayJT3LU/et8RjBN3Zozb+e3Jkq/vit6N46VCaRoursRYAqfXLy5AAxZdOrNbfgsoMFthAFZFB/an/D85eN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770975; c=relaxed/simple;
	bh=QPnXynynXjG10ullDNsO7VmGGYw/z1Un2ZNUe4EXu98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpbY3ZI+KkfERLa264M01CQHS4P4ZA7/urvhjbmSlO89WPNEcv6D3bBBcwBN78tBkPpRP+y+3CYtrh+RAg1YKI67aI82dyWXGzTaGdQs4oPjZkohgScUuOWIvbpSpghluVF/1JlVcvhwBJNICIuW0VSIB5XET2VrHMAB4QRjS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=nDzW5UBF; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T9Qsn+owaaej5zrPQzEap5fL6Byc4tHr9W1jenKmGTI=; b=nDzW5UBFZOg+pkVoObYSSaxdXq
	vXykA/2xTjyrV1uTczrBRFrtIdfdP5AYwEDqjM7JXqtkplOo9/1cYsGhAkhSfuIYBMrvvAfBqxqDz
	K+RZrnDEu3txeduPT/Fc4YaRAjMvrcFMurafXcAXmnJrYEVamIBY9okx105g0ybeASPAammJFw8Sa
	JCWfRET45BaACqsJmFd3uBfZesarfukMM68lBOP0LP4JqT4bmRQ4MMvmkYF4WxARTEHq80tf2CPWM
	E1fcEZuPkIw/HXYvfracFbXeoma6TwRQN8qvr4WYHDUTR7i5f4Eb8kTqXqytrvKAyTHSno1P0YYdg
	Or9fy6Gg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyb-001Gd5-3C;
	Mon, 09 Dec 2024 12:59:26 -0600
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
Subject: [PATCH v6 15/28] selftests: ntsync: Add some tests for mutex state.
Date: Mon,  9 Dec 2024 12:58:51 -0600
Message-ID: <20241209185904.507350-16-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test mutex-specific ioctls NTSYNC_IOC_MUTEX_UNLOCK and NTSYNC_IOC_MUTEX_READ,
and waiting on mutexes.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 1e145c6dfded..7cd0f40594fd 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -40,6 +40,39 @@ static int post_sem(int sem, __u32 *count)
 	return ioctl(sem, NTSYNC_IOC_SEM_POST, count);
 }
 
+static int read_mutex_state(int mutex, __u32 *count, __u32 *owner)
+{
+	struct ntsync_mutex_args args;
+	int ret;
+
+	memset(&args, 0xcc, sizeof(args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &args);
+	*count = args.count;
+	*owner = args.owner;
+	return ret;
+}
+
+#define check_mutex_state(mutex, count, owner) \
+	({ \
+		__u32 __count, __owner; \
+		int ret = read_mutex_state((mutex), &__count, &__owner); \
+		EXPECT_EQ(0, ret); \
+		EXPECT_EQ((count), __count); \
+		EXPECT_EQ((owner), __owner); \
+	})
+
+static int unlock_mutex(int mutex, __u32 owner, __u32 *count)
+{
+	struct ntsync_mutex_args args;
+	int ret;
+
+	args.owner = owner;
+	args.count = 0xdeadbeef;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_UNLOCK, &args);
+	*count = args.count;
+	return ret;
+}
+
 static int wait_any(int fd, __u32 count, const int *objs, __u32 owner, __u32 *index)
 {
 	struct ntsync_wait_args args = {0};
@@ -146,4 +179,167 @@ TEST(semaphore_state)
 	close(fd);
 }
 
+TEST(mutex_state)
+{
+	struct ntsync_mutex_args mutex_args;
+	__u32 owner, count, index;
+	struct timespec timeout;
+	int fd, ret, mutex;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 0;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 2;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 2;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, 2, 123);
+
+	ret = unlock_mutex(mutex, 0, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	ret = unlock_mutex(mutex, 456, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+	check_mutex_state(mutex, 2, 123);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_mutex_state(mutex, 1, 123);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, count);
+	check_mutex_state(mutex, 0, 0);
+
+	ret = unlock_mutex(mutex, 123, &count);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	ret = wait_any(fd, 1, &mutex, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 456);
+
+	ret = wait_any(fd, 1, &mutex, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 2, 456);
+
+	ret = unlock_mutex(mutex, 456, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+	check_mutex_state(mutex, 1, 456);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	owner = 0;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	owner = 123;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EPERM, errno);
+	check_mutex_state(mutex, 1, 456);
+
+	owner = 456;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	owner = 123;
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	memset(&mutex_args, 0xcc, sizeof(mutex_args));
+	ret = ioctl(mutex, NTSYNC_IOC_MUTEX_READ, &mutex_args);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, mutex_args.count);
+	EXPECT_EQ(0, mutex_args.owner);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	close(mutex);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, 0, 0);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_mutex_state(mutex, 1, 123);
+
+	close(mutex);
+
+	mutex_args.owner = 123;
+	mutex_args.count = ~0u;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+	mutex = mutex_args.mutex;
+	check_mutex_state(mutex, ~0u, 123);
+
+	ret = wait_any(fd, 1, &mutex, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	close(mutex);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


