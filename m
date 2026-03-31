Return-Path: <linux-api+bounces-6045-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJBxFRAKzGn+NQYAu9opvQ
	(envelope-from <linux-api+bounces-6045-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:53:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C199336F6F6
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497AE30E4009
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA2345753;
	Tue, 31 Mar 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tqB1VxkX"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C86345750
	for <linux-api@vger.kernel.org>; Tue, 31 Mar 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977619; cv=none; b=JrIDUFztRx4TuR7FsYXl4FvK2vJ7NJwwxTXuWSa5Z3pR/TeYTdBRXUUQvAk6hF7k0y3iZLSHceFhEVXhflycwgXuY8s4XbpNVqU2kLJbRUdANKWR3cNUEBUT9IzHRe4LEIQ9a+eZjnGslidB1HqaxNmSmuD8ZHMAQq+0xggOBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977619; c=relaxed/simple;
	bh=9a07OI6G1FdXoYEj20uLFgzwaAk/WzZPhJzya892ozs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKwtSme1n3Hg9JqqFA81Ji6fRFFch/d4JyuXGR6tRM9uQLocY27TmMsoJZ9Zyw7u7FADqf+Z6aP5VSb6ea/rB6/0VrFGrToQpC+iubvXLazxEb4VP3LNXCFvzNT3IPxPAxYRJkm92bSRYk7US2Ka27sogjtER/KtvcUm/rekhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tqB1VxkX; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: de11ed37-2d25-11f1-afda-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id de11ed37-2d25-11f1-afda-005056994fde;
	Tue, 31 Mar 2026 19:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SIY1aVd3TcIR+nTkIuM5SR5/9+HgkFFEgimZ8yE4G08=;
	b=tqB1VxkXY04rr1gw4sen7pOZ+4espDd5si4hmDvbDs3rI2V5zC6l9XiPEiOj85Ml7m46NJFPIFgbN
	 PyC2DkHepNrlNZcf3dGv7IEj57keOh4w1I6sbxia37z7GfDHnwUSsxaS3N6GVpCyJZrEvlx2ojG/LE
	 I4zc1CGQU+Mr6+56eBMgjL181Lx5CfFabpzOjokHsBf1Q5rWE9QAg5UrVpbdKYIJyUArZNOI3uWr6W
	 CPYl7/yw0/fX9WXCaOEIhAYDBHTxVomB/OQi8BqPoEB5vVRseePONCGJQzRX98prtxkMLEjF5vbzT3
	 utSsfnQlE0eF+o8CxfP1auwtZyPndrQ==
X-KPN-MID: 33|XhdlY57GqcJB9oU2yafxIvsJwRD0xG8SHogByN+EIthGLyczyWBdQ2S/dNClDRD
 cG/2KpUPLW1cZ4+fpJaskse1e5/a7GSk9YTLm0WWcpyI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bvc7FnJEwJFayum3+kDCzfBY/LJYd9rL59Eha9ifk0Jbk0xbsrPs+Z10Nufunsa
 7payj/KUH2JoFtYqtlu00/Q==
Received: from daedalus.home (unknown [178.227.25.158])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id daba308f-2d25-11f1-86d5-005056998788;
	Tue, 31 Mar 2026 19:20:08 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [RFC PATCH 0/2] vfs: mkdirat_fd() syscall
Date: Tue, 31 Mar 2026 19:19:57 +0200
Message-ID: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,suse.cz,gmail.com,infradead.org,redhat.com,kernel.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-6045-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:mid]
X-Rspamd-Queue-Id: C199336F6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series implements the mkdirat_fd() syscall that was suggested over
at the UAPI group kernel feature page [1] with some tests.

Obviously, if we want this we should also implement mknodeat_fd() and
symlinkat_fd(), but their implementation can be done quite similar I
believe.

I have added an unigned int flags like [2] suggests and an example flag
that we may want to remove (it right now mainly serves an internal
purpose). But it marks where I would want to place the definitions.

This has been compiled and tested on x86 only. [2] is a bit confusing
here and there, so I hope I have added the proper syscall definitions
everywhere where they needs to be added.

[1]: https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
[2]: https://www.kernel.org/doc/html/latest/process/adding-syscalls.html

Jori Koolstra (2):
  vfs: syscalls: add mkdirat_fd()
  selftest: add tests for mkdirat_fd()

 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 fs/internal.h                                 |   1 +
 fs/namei.c                                    |  26 +++-
 include/linux/fcntl.h                         |   2 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/fcntl.h              |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 scripts/syscall.tbl                           |   1 +
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 .../selftests/filesystems/mkdirat_fd_test.c   | 139 ++++++++++++++++++
 11 files changed, 183 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mkdirat_fd_test.c

-- 
2.53.0


