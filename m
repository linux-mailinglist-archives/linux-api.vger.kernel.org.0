Return-Path: <linux-api+bounces-5986-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GoNvAolTtmkJAgEAu9opvQ
	(envelope-from <linux-api+bounces-5986-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 07:36:57 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5661B290137
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 07:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169CD304C609
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450BA1D88B4;
	Sun, 15 Mar 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XALRt/o0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F935898;
	Sun, 15 Mar 2026 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773556613; cv=none; b=etlwFFLfBEVx7TJgbGPwvmGQ6azfus04EEMQrhNmpbCLDTEwg5sVRZbMM/gDwluwmb1QRQX0ib8oOHQm2fs0BTGgVafo9Wt7sYbWvhrsUgVEJK8UNiCmVXc8VKBfEhvGdttDY+2QvfFUGCBK5AYh9uGPAaFeE4y+6hmSklRVSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773556613; c=relaxed/simple;
	bh=KBSdUW2G6hxoghM+ni0Lk6NucV+M0q3TNqfLhjtlu+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD4VVT5RWl+ZViVhIlihdD+TmC3BUUFhLllq+FkO4fwP7AIT2+h5B5VhVNoJ8qZuCJ4iHkLZ3bKF1iKtCHJRbU9lxhfGfzokVexncWjuVNhqYUl+YubFaDDjhJ5M1wNKK2m5Nd+0eCLeSEJZJieEuBBTxg1MGqsvTFP2f2ZE9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XALRt/o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7612DC4CEF7;
	Sun, 15 Mar 2026 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773556612;
	bh=KBSdUW2G6hxoghM+ni0Lk6NucV+M0q3TNqfLhjtlu+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XALRt/o0dd2AxQBMPmSEoHdvSVrVl0oXns2o/a8Ey90Yg4CIvJGDRM7j/B9xDOTOv
	 jVkwQfiy2XHpW6QGkRlISJca8zcc437g6Zst1xVvd/Nn3ZvfdIobB455dlA+fjZXun
	 GYkGmlyzr37rzEwy1AapZ/pkqk1QNFoooCb6x1r7g+zWI5GFMpOe7rFD/PUgyrhvz3
	 XPi7roPO9OIUo48wKKgk4p8/sFXHGlwSAXV11MrAbE3SXHRgLsh2L9SIFaN6/dG3jl
	 jptJ5NIB5rWb5FrWRiKgxREhtCdmklti3MakwpEp07gLdDtys6XyVroLDF4G9kiviQ
	 GDDOQ+Cfq8qAw==
Date: Sun, 15 Mar 2026 02:36:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <abZTg9ZwnE5J4qXa@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260314111822.63a2ba4a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260314111822.63a2ba4a@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5986-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5661B290137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:18:22AM -0700, Jakub Kicinski wrote:
>On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
>> This enables static analysis tools to verify userspace API usage at compile
>> time, test generation based on formal specifications, consistent error handling
>> validation, automated documentation generation, and formal verification of
>> kernel interfaces.
>
>Could you give some examples? We have machine readable descriptions for
>Netlink interfaces, we approached syzbot folks and they did not really
>seem to care for those.

Once the API is in a machine-readable format, we can write formatters to
output whatever downstream tools need. The kapi tool in the series
already ships with plain text, JSON, and RST formatters, and adding new
output formats is straightforward. We don't need to convince the
syzkaller folks to consume our specs, we can just output them in a
format that syzkaller already understands.

For example, I have a syzlang formatter that produces the following
from the sys_read spec in this series:

   # --- read ---
   # Read data from a file descriptor
   #
   # @context process, sleepable
   #
   # @capability CAP_DAC_OVERRIDE: Bypass discretionary access control on read permission
   # @capability CAP_DAC_READ_SEARCH: Bypass read permission checks on regular files
   #
   # @error EPERM (-1): Returned by fanotify permission events...
   # @error EINTR (-4): The call was interrupted by a signal before any data was read.
   # @error EIO (-5): A low-level I/O error occurred.
   # @error EBADF (-9): fd is not a valid file descriptor, or fd was not opened for reading.
   # @error EAGAIN (-11): O_NONBLOCK set and read would block.
   # @error EACCES (-13): LSM denied the read operation via security_file_permission().
   # @error EFAULT (-14): buf points outside the accessible address space.
   # @error EISDIR (-21): fd refers to a directory.
   # @error EINVAL (-22): fd not suitable for reading, O_DIRECT misaligned, count negative...
   # @error ENODATA (-61): Data not available in cache...
   # @error EOVERFLOW (-75): File position plus count would exceed LLONG_MAX.
   # @error EOPNOTSUPP (-95): Read not supported for this file type...
   # @error ENOBUFS (-105): Buffer too small for complete notification...
   #
   # @constraint MAX_RW_COUNT: actual_count = min(count, MAX_RW_COUNT)
   # @constraint File must be open for reading: (file->f_mode & FMODE_READ) && (file->f_mode & FMODE_CAN_READ)
   #
   # @signal Any signal: restartable, error=-4
   #
   # @lock file->f_pos_lock (mutex, internal): For seekable files with FMODE_ATOMIC_POS
   # @lock Filesystem-specific locks (rwlock, internal)
   # @lock RCU read-side (rwlock, internal): File descriptor lookup protection
   #
   # @side-effect file->f_pos: f_pos advanced by bytes read [conditional, irreversible]
   # @side-effect inode access time: atime updated unless O_NOATIME [conditional, irreversible]
   # @side-effect task I/O accounting: rchar and syscr updated [conditional, irreversible]
   # @side-effect fsnotify events: FS_ACCESS event generated [conditional, irreversible]
   #
   # @return ssize_t: bytes read on success, negative errno on error
   #
   read(fd fd, buf ptr[out, buffer[out]], count len[buf]) intptr

That said, I don't have a strong end-to-end example with the 4 syscalls
proposed here, as open/close/read/write don't take complex structures,
and the subsystems underneath them aren't specced yet. The value becomes
clearer with richer interfaces where the gap between "we know the type
signature" and "we know the full behavioral contract" is much wider.

-- 
Thanks,
Sasha

