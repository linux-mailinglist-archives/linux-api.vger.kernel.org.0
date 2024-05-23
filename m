Return-Path: <linux-api+bounces-1593-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD28CDB34
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F078B1C209A4
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95984A4E;
	Thu, 23 May 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PVfROZdl"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109A7CF30;
	Thu, 23 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494860; cv=none; b=j0hIdkJzo2OKc8T8ML5Ih7zgvrA+oBl5moL4CleTx2CHu5WAPFOpqwJbijQuWxarKLPddJFvmVAfubcvM8Qw31NqW6OrZiQDfmbykDBT42ZQw846HaYu0AH8nxDSZ3xOmsZXktfowGwYdp/2/NMsKDm1asEZvCd4UVfLK6YY7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494860; c=relaxed/simple;
	bh=iZrphTEqMOGCT96r7nEcEQdllx5byLvE5QbEGAdCWpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iu2Z76737d4YlP30Nzqz+t5ADawEA8c2LJiceugXHwt9OQcQ/ae2GWyyJ92A/6sZhX4nOt8927NcT/mjLi3H36ODXMS+E/Wqc8yiSrJhhxPs8lg5ePyUB8RMJP29tbJgqo+vLT2zo8b8RFnhBoMiz0ctjZZ068hJsu8qVZpLD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PVfROZdl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+RKBUDWRrMarm2gr40PiqR7AOLsy7jlxbXPbY/6bQJk=; b=PVfROZdlzV1Gg2kWL64WllVIep
	0ZKKCFJX1vGJKZ3JXyemRZ1TQCy7dYgNSuLs8IK9gM1KznqiQ0XINruQ7L/DrI7KEvriBhMVvcLgy
	XA1tQ3u4hHYOpwJwUJuFs1HkNGdZsLTy26PBJ3GaKz3YEUOSZc0iSu3YofnWLl3GDQrRHnxtzfZ5H
	f6qChLd4lQZywfmETtlJhFi26U0mob6W4LWsgDNzLREIZD7zQyeHwLGngKVjWvxE7ROmITknoX6rL
	E4Kmo37vO1ux+kYXzVif0O1mMnkkhUnyQbJDb2gr+nbBxpcfwgyKU33bHs/FIe0HcqWQqTPZOQXYM
	wVSMKYsw==;
Received: from [191.8.29.37] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sAEiZ-00BhS0-BS; Thu, 23 May 2024 22:07:15 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Paul Turner" <pjt@google.com>,
	linux-api@vger.kernel.org,
	"Christian Brauner" <brauner@kernel.org>,
	"Florian Weimer" <fw@deneb.enyo.de>,
	David.Laight@ACULAB.COM,
	carlos@redhat.com,
	"Peter Oskolkov" <posk@posk.io>,
	"Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
	"Chris Kennelly" <ckennelly@google.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Darren Hart" <dvhart@infradead.org>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	libc-alpha@sourceware.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Noah Goldstein" <goldstein.w.n@gmail.com>,
	"Daniel Colascione" <dancol@google.com>,
	longman@redhat.com,
	kernel-dev@igalia.com
Subject: [PATCH v2 0/1] Add FUTEX_SPIN operation
Date: Thu, 23 May 2024 17:07:03 -0300
Message-ID: <20240523200704.281514-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
rseq interface to be able to implement spin locks in userspace correctly. Thomas
Gleixner agreed that this is something that Linux could improve, but asked for
an alternative proposal first: a futex operation that allows to spin a user
lock inside the kernel. This patchset implements a prototype of this idea for
further discussion.

With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
be the TID of the lock owner. Then, the kernel gets the task_struct of the
corresponding TID, and checks if it's running. It spins until the futex
is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
is scheduled out at any time, then the syscall follows the normal path of
sleeping as usual. The user input is masked with FUTEX_TID_MASK so we have some
bits to play.

If the futex is awaken and we are spinning, we can return to userspace quickly,
avoid the scheduling out and in again to wake from a futex_wait(), thus
speeding up the wait operation. The user input is masked with FUTEX_TID_MASK so
we have some bits to play.

Christian Brauner suggested using pidfd to avoid race conditions, and I will
implement that in the next patch iteration. I benchmarked the implementation
measuring the time required to wait for a futex for a simple loop using the code
at [2]. In my setup, the total wait time for 1000 futexes using the spin method
was almost 10% lower than just using the normal futex wait:

	Testing with FUTEX2_SPIN | FUTEX_WAIT
	Total wait time: 8650089 usecs

	Testing with FUTEX_WAIT
	Total wait time: 9447291 usecs

However, as I played with how long the lock owner would be busy, the
benchmark results of spinning vs no spinning would match, showing that the
spinning will be effective for some specific scheduling scenarios, but depending
on the wait time, there's no big difference either spinning or not.

[0] https://lpc.events/event/17/contributions/1481/

You can find a small snippet to play with this interface here:

[1] https://gist.github.com/andrealmeid/f0b8c93a3c7a5c50458247c47f7078e1

Changelog:

v1: - s/PID/TID
    - masked user input with FUTEX_TID_MASK
    - add benchmark tool to the cover letter
    - dropped debug prints
    - added missing put_task_struct()

André Almeida (1):
  futex: Add FUTEX_SPIN operation

 include/uapi/linux/futex.h |  2 +-
 kernel/futex/futex.h       |  6 ++-
 kernel/futex/waitwake.c    | 78 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.45.1


