Return-Path: <linux-api+bounces-6023-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOBFI33lwGl6OQQAu9opvQ
	(envelope-from <linux-api+bounces-6023-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:21 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0092ED382
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5DE300FC5A
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66C2D0C9C;
	Mon, 23 Mar 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7rz3TJI"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEB223DCE;
	Mon, 23 Mar 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249335; cv=none; b=pWFcKfA7W/jGCcCTzfJoRwB1pUsZPdUhM1fl1CQBMG4A6TBBllLQW2u/GpkFJACTvIXKL4eHq9Mzj35hi7AVZvKlpmiU0Lhi6PXnCBzHZaYVjmLp8o7PkeHTrzWGQxn3CASV+N9svN/V0BITPDGLqz2Wk899pZp1jvp7qjUyRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249335; c=relaxed/simple;
	bh=phn0NHtxfUMiCYiqOlOzPZsl5aiO8cwuYKCA50ngr/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bb+p4CiBYNxQIrJ3v7MAg6oliQkIhaYb3KFFPnLPLAtVSQIsrOD7Xj7kit/hFobzTOBZLd8+Eb4o1ybNwermWRxYffJ+l6jhSyRxGndP/F2WurKqDVoEsP5a+V1U8cU9P1JIlt5SPrtkYq7wglILCxNU2T6wrK6WqSZShwqgd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d7rz3TJI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ymKLyHDUS1Lu6tStQ0lnD46LWrM7guBhCULfBOM2RqI=; b=d7rz3TJIO5VfLVTCv6nD8Xnzpy
	b30BT6XjmyaGSr0JxhLjSl7zn3uR/MAH6ReoCZRgIETHDH9xETuWjVl1uRgMTja5hExmiG/huXj/+
	I2j7olvaQhY8aeJoqZzCnwYVJC9uyiWYzhx7I3ddO77ONjJOXQbA2QyA/wh4b6nqNHihx0/fRnHR4
	U/oe1EA/ztH2sNKmPNvEi78LRUy02mkByquMVrtYjUTjQO7csjDuoBO4q0uMiw9T+C2Qbwwp+ioUD
	V9zGUDjjZp9w/vA6QMzaWpGFhnDn2zPvL6tx7CuC5bT3HTvyqKTRjd/H+KwKSftEdoFUHhJqPNQYx
	SsVwiEzA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIi-0000000G9ib-15sM;
	Mon, 23 Mar 2026 07:02:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: fix architecture-specific compat_ftruncate64 implementations
Date: Mon, 23 Mar 2026 08:01:43 +0100
Message-ID: <20260323070205.2939118-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6023-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-api@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: DE0092ED382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this series fixes a really old bug found by code inspection, where the
architecture-specific 32-bit compat ftruncate64 implementations enforce
the non-LFS file size limit unless opened with O_LARGEFILE.

Diffstat:
 arch/arm64/kernel/sys32.c       |    2 +-
 arch/mips/kernel/linux32.c      |    2 +-
 arch/parisc/kernel/sys_parisc.c |    4 ++--
 arch/powerpc/kernel/sys_ppc32.c |    2 +-
 arch/sparc/kernel/sys_sparc32.c |    2 +-
 arch/x86/kernel/sys_ia32.c      |    3 ++-
 fs/internal.h                   |    3 +--
 fs/open.c                       |   40 +++++++++++++++++++---------------------
 include/linux/syscalls.h        |   16 +++-------------
 io_uring/truncate.c             |    2 +-
 10 files changed, 32 insertions(+), 44 deletions(-)

