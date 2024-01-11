Return-Path: <linux-api+bounces-486-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC882B345
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 17:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A016D1F29BB5
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210DB50270;
	Thu, 11 Jan 2024 16:46:12 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A89524A9
	for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Thu, 11 Jan 2024 11:46:21 -0500
From: Rich Felker <dalias@libc.org>
To: libc-alpha@sourceware.org, musl@lists.openwall.com,
	linux-api@vger.kernel.org
Subject: Robust mutex ABI problem (kernel docs regression)
Message-ID: <20240111164620.GS4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

It came to my attention while reviewing some proposals for additional
error checking in musl libc that the kernel folks introduced a quiet
regression in the futex ABI for robust mutexes.

Prior to kernel commit 9c40365a65d62d7c06a95fb331b3442cb02d2fd9, bit
29 of the futex lock word was reserved, meaning it could never be part
of a TID. This allowed both glibc and musl to use special values like
(glibc):

/* Magic cookie representing robust mutex with dead owner.  */
#define PTHREAD_MUTEX_INCONSISTENT      INT_MAX
/* Magic cookie representing not recoverable robust mutex.  */
#define PTHREAD_MUTEX_NOTRECOVERABLE    (INT_MAX - 1)

to represent special states needed for robust mutex consistency
handling, without the risk that, when masked with FUTEX_TID_MASK
(0x3fffffff), they could be equal to the TID of a real task, which
could result in the kernel robustlist-processing mishandling them.

In practice this is only a documentation regression. The real limit on
TIDs is well below that, at something like 22-bit last I checked.
However to be future-proof, and as other systems may implement the
Linux API/ABI (e.g. things like WSL1, FreeBSD Linux syscall layer,
etc.), I believe it's important that the documented interface be
compatible with the way it actually needs to be used here. This means
either bit 29 should have its reserved status restored, or there
should be a guarantee that the values 0x3fffffff and 0x3ffffffe are
reserved and compare not-equal to any actual TID.

Depending on how folks want to proceed with this, I can propose a
patch to the documentation, or leave that to others.

Rich

