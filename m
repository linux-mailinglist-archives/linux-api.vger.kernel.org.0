Return-Path: <linux-api+bounces-6082-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGerG3ek22ldEgkAu9opvQ
	(envelope-from <linux-api+bounces-6082-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A13E4130
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17C743012CA4
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D9B2FD1AA;
	Sun, 12 Apr 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lkdcleIB"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77272EDD6B
	for <linux-api@vger.kernel.org>; Sun, 12 Apr 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002158; cv=none; b=DdrF58J7+N8KigvpR6D+l7iV+jAeub7O/sOuKuOnlQHY+TLGiqp7iwK9oI3m3hluD+3jSFCkuEFiMSlvATP4KM7zwiAIDsjhBo1zjsfcQRGMEeV9GCBQw1q3ECeI4XekmLV3kDzzEG1fPllc3fTJE8ED/y9ZTOhh9VQXYzD9FSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002158; c=relaxed/simple;
	bh=tl88h0UZA8OnkTP4gd1VP3tBY9jZtevwAXX21nfm4aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEa5wH1p+j+zBf/T/RlXgh1LtXw0Z+EGps0ATyoFpy5xIpdotW+ewd0BhCaDDNDs6Nvxb62AKhLwM708/wJzxhq3KAUPZWaLtpCT87r4FQQbELhTRoeEGeAaWLtomYYhxnESPiRsmcc2qYqbYIoTDKX7c/1lCXlv29RGGsp540Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lkdcleIB; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 2a307600-3677-11f1-8a9b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2a307600-3677-11f1-8a9b-005056ab378f;
	Sun, 12 Apr 2026 15:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EHi8TLrImTXi57iAivUqNFaFSoUEH6II3C7aGD5935g=;
	b=lkdcleIBhUh+qckOHYjJyC0DvVV2E0yjh7ajuDy2a0i044I6csVx2qr7qSt8wG9u1izb0zvQCdE2q
	 r5YxKxWX1Pw2r//rUjwQB8hQT50RMMjr52anSlBL9hEunkRj8TqpbPdody1QCV/DVJtiNewcDB9HJ/
	 G4KDOGhX/o2T5Q/qKgcqKNtq8UMa4/2LZ71JdUARWzx+icc6Ck9pJdKGRZvL2kCuwdrOAprpBRQFu8
	 R/OGF4U1NYV1rv61oI/yvL30RO3DlgTc90Z32VHKMoSSoz1RQO7QC/rrDEDWx8Aa/DET5PIZJqcGPg
	 YhL1hjR9hWZoLP9kHjTVSxULJ+oHqpA==
X-KPN-MID: 33|6NbBVknz/hcGP6i3BtMVY7a3/gLx/cmp9SewgkP7x2GpQbq17g45rpYdq5lmO5P
 nQGRM3k7Uw+iM0RUtkfUnDXhOPkfYa8wSPQGiPC+bVmY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4QPKutfvJKL6ZbZdIySMJ5wDYY/4wTEZwnyOJQmVWpMHKGYWwYjdPS80ApcuvjF
 ti3dkNbzMNzrSiPxnF2/LNg==
Received: from daedalus.home (unknown [178.230.185.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 271b930a-3677-11f1-8011-005056ab7447;
	Sun, 12 Apr 2026 15:54:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	cmirabil@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v2 0/2] vfs: syscalls: add mkdirat2() that returns an O_DIRECTORY fd
Date: Sun, 12 Apr 2026 15:54:32 +0200
Message-ID: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[zytor.com,suse.cz,infradead.org,redhat.com,kernel.org,xs4all.nl,linutronix.de,efficios.com,cyphar.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6082-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:mid]
X-Rspamd-Queue-Id: CD1A13E4130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series implements the mkdirat2() syscall that was suggested over
at the UAPI group kernel feature page [1] with some tests.

Obviously, we probably also want to implement equivalent mknodeat2() and
symlinkat2() syscalls, but their implementation can be done quite similar
I believe.

This has been compiled and tested on x86 only.

[1]: https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

v2:
- Use AT_* flags.
- Ensure an fd is allocated only if mkdir and open_dentry succeed.
- The returned fd gets O_CLOEXEC by default.
- Renamed syscall from mkdirat_fd() to mkdirat2().

Jori Koolstra (2):
  vfs: syscalls: add mkdirat2() that returns an O_DIRECTORY fd
  selftest: add tests for mkdirat2()

 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 fs/internal.h                                 |   2 +
 fs/namei.c                                    |  44 +++++-
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 scripts/syscall.tbl                           |   1 +
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   4 +-
 .../selftests/filesystems/mkdirat_fd_test.c   | 143 ++++++++++++++++++
 10 files changed, 200 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mkdirat_fd_test.c

-- 
2.53.0


