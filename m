Return-Path: <linux-api+bounces-1546-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02428C966F
	for <lists+linux-api@lfdr.de>; Sun, 19 May 2024 22:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC2B20BE9
	for <lists+linux-api@lfdr.de>; Sun, 19 May 2024 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3187477F15;
	Sun, 19 May 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="R1+a6ELS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E26EB5D;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150320; cv=none; b=IhRGrmym+g3+wx/FZTNZGitigwoDR4TdWw4GiSQVgte1HsaFmL20GOjvyYNntN+3XxGJPH4yfxp3FIPK09SVM7xGy4Cnr55mPgMk/c42nV01iBkoPyQN5Qw8FMqA1NSV3hjplG1NaMTvcLqFwK778/Sg1R/IxCi0f5nDAem30YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150320; c=relaxed/simple;
	bh=5mBQOp6SjQPwQE2r7Sw+cmn32H8r+RTlbfg4A/JMPOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfYgDM54JZrV0w+Bhp7x4w7aSacKcpv/3qMWtgnEnPy0GcJS73xIGl2+7o0CeL1AB8AnclHxdKliy88iHuOOsUDuOxP+RRK/3rdz11JHwSjFFt5CwW1gF0Nusi0CwfkUo8SMK1kP3SCLbo88feLq1D4F06XA9jtyJz7D0uhlVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=R1+a6ELS; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=fI5a+2dMHnk+GhHmYILNu5mjq8uQWm3pTL4zsGR4SNg=; b=R1+a6ELStS2JYdRMN9fmE60rVw
	+Akgf7wbvWIbcOUoCBNxGP3Y69fSWoM7Ut7AbLfdvFnXW5EBdDKlslNtTfIBag0QtuZkt5E5aKhGw
	z5uoofGbyWeS8eQdwFKc1t37I7DUg1lSpI1ycHS2K73udUq47kvcRMVd9b8cROWeBDMOn2jimCDtJ
	AdcgDfTGPbokZ/mc7h58wR46XF4kiBZJ3KCDCU/f2w3x0/K0dFeEJlzm20RbWoXggyMQVhaxIxqcl
	DcFnXd5UPmVPz99QYFTAJqaGZr8ZDzyhHfSkg2trWEowsfzmIn4zd1OnjVikeq/hSbCN5oS99WiKa
	OPtIbaVg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5e-008wIn-1F;
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
Subject: [PATCH v5 18/28] selftests: ntsync: Add some tests for wakeup signaling with WINESYNC_IOC_WAIT_ANY.
Date: Sun, 19 May 2024 15:24:44 -0500
Message-ID: <20240519202454.1192826-19-zfigura@codeweavers.com>
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

Test contended "wait-for-any" waits, to make sure that scheduling and wakeup
logic works correctly.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index c0f372167557..993f5db23768 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -556,4 +556,154 @@ TEST(test_wait_all)
 	close(fd);
 }
 
+struct wake_args {
+	int fd;
+	int obj;
+};
+
+struct wait_args {
+	int fd;
+	unsigned long request;
+	struct ntsync_wait_args *args;
+	int ret;
+	int err;
+};
+
+static void *wait_thread(void *arg)
+{
+	struct wait_args *args = arg;
+
+	args->ret = ioctl(args->fd, args->request, args->args);
+	args->err = errno;
+	return NULL;
+}
+
+static __u64 get_abs_timeout(unsigned int ms)
+{
+	struct timespec timeout;
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+	return (timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
+}
+
+static int wait_for_thread(pthread_t thread, unsigned int ms)
+{
+	struct timespec timeout;
+
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_nsec += ms * 1000000;
+	timeout.tv_sec += (timeout.tv_nsec / 1000000000);
+	timeout.tv_nsec %= 1000000000;
+	return pthread_timedjoin_np(thread, NULL, &timeout);
+}
+
+TEST(wake_any)
+{
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_wait_args wait_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	struct wait_args thread_args;
+	int objs[2], fd, ret;
+	__u32 count, index;
+	pthread_t thread;
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 0;
+	sem_args.max = 3;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+
+	mutex_args.owner = 123;
+	mutex_args.count = 1;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+
+	objs[0] = sem_args.sem;
+	objs[1] = mutex_args.mutex;
+
+	/* test waking the semaphore */
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.objs = (uintptr_t)objs;
+	wait_args.count = 2;
+	wait_args.owner = 456;
+	wait_args.index = 0xdeadbeef;
+	thread_args.fd = fd;
+	thread_args.args = &wait_args;
+	thread_args.request = NTSYNC_IOC_WAIT_ANY;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	count = 1;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+	check_sem_state(sem_args.sem, 0, 3);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(0, wait_args.index);
+
+	/* test waking the mutex */
+
+	/* first grab it again for owner 123 */
+	ret = wait_any(fd, 1, &mutex_args.mutex, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	wait_args.timeout = get_abs_timeout(1000);
+	wait_args.owner = 456;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(2, count);
+
+	ret = pthread_tryjoin_np(thread, NULL);
+	EXPECT_EQ(EBUSY, ret);
+
+	ret = unlock_mutex(mutex_args.mutex, 123, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, mutex_args.count);
+	check_mutex_state(mutex_args.mutex, 1, 456);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, thread_args.ret);
+	EXPECT_EQ(1, wait_args.index);
+
+	/* delete an object while it's being waited on */
+
+	wait_args.timeout = get_abs_timeout(200);
+	wait_args.owner = 123;
+	ret = pthread_create(&thread, NULL, wait_thread, &thread_args);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_for_thread(thread, 100);
+	EXPECT_EQ(ETIMEDOUT, ret);
+
+	close(sem_args.sem);
+	close(mutex_args.mutex);
+
+	ret = wait_for_thread(thread, 200);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(-1, thread_args.ret);
+	EXPECT_EQ(ETIMEDOUT, thread_args.err);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0


