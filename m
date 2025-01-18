Return-Path: <linux-api+bounces-3055-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA21DA15D48
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2025 15:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A226F3A78D3
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59505192B85;
	Sat, 18 Jan 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGkdVAmO"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FF188A08
	for <linux-api@vger.kernel.org>; Sat, 18 Jan 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737209661; cv=none; b=kVK4XQquWuwn7o2nzhutMpThcKC9ZRwTEpURo66R7Yx9a186ujJow5m99JMUQbC1yQMtaDbWkZhx2yILopCg8h+aXnU+imd/QyC8UVbFeTu6RnqsEi5agj3A6iIXVulDxZZZye/nSdm19iKYUCTAvXHDwB+/gsdVe6QHITSIGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737209661; c=relaxed/simple;
	bh=euNajMSl3CSuVvLA04olHLbYKm1lKV81Th7+QMunxdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTCVQsURstPjdo3fzKRnSY9iPKsJca37tHxv9f/KMm/rKaGn0m2OVmxaF641tMLkwPyjkWRtAAlc+kq17PIN8YmNeuvf1yzoYWzAJ59YlPaOB5KRc2qLCby2qyMwooBTkbkb3duy73JRdRCSGJzTaC55nb1n15bNzsRnhgEROUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGkdVAmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737209658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Khr+eUaHrDV0x8K9dMAHl80WGNO4INMGzu+IlLPXXYA=;
	b=TGkdVAmOK3Uet9T/nlPKdQS6T6x3iLIykxfZcphXBA3AcAodt0icjNjnzg/MCbgX3pAZ+j
	3taTIRtZcZsmZhO7aUL9TLDQzaqwNBWITQrHQRYiq4PCf+YxPrwzoBhvvXL3/LOIJ77EMi
	oVIXsXS3m5l1bUyl7veLJWyEx2rlGJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-iNo5JJRlOn25PthtXLFdqw-1; Sat,
 18 Jan 2025 09:14:14 -0500
X-MC-Unique: iNo5JJRlOn25PthtXLFdqw-1
X-Mimecast-MFC-AGG-ID: iNo5JJRlOn25PthtXLFdqw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B8F119560AF;
	Sat, 18 Jan 2025 14:14:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7B28C19560BF;
	Sat, 18 Jan 2025 14:14:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jan 2025 15:13:47 +0100 (CET)
Date: Sat, 18 Jan 2025 15:13:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250118141341.GA21464@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
 <20250117153258.GC21203@redhat.com>
 <20250117162255.GA15597@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117162255.GA15597@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/17, Dmitry V. Levin wrote:
>

(reordered)

> struct ptrace_syscall_info has members of type __u64, and it currently
> ends with "__u32 ret_data".  So depending on the alignment, the structure
> either has extra 4 trailing padding bytes, or it doesn't.

Ah, I didn't realize that the last member is __u32, so I completely
misunderstood your "it depends on the alignment of __u64" note.

> For example, on x86_64 sizeof(struct ptrace_syscall_info) is currently 88,
> while on x86 it is 84.

Not good, but too late to complain...

OK, I see your point now and I won't argue with approach you outlined in your
previous email

        size_t min_size = offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
        size_t copy_size = min(sizeof(info), user_size);

        if (copy_size < min_size)
                return -EINVAL;

        if (copy_from_user(&info, datavp, copy_size))
                return -EFAULT;

-------------------------------------------------------------------------------
Thats said... Can't resist,

> An absolutely artificial example: let's say we're adding an optional
> 64-bit field "artificial" to ptrace_syscall_info.seccomp, this means
> sizeof(ptrace_syscall_info) grows by 8 bytes.  When userspace wants
> to set this optional field, it sets a bit in ptrace_syscall_info.flags,
> this tells the kernel to look into this new "artificial" field.
> When userspace is not interested in setting new optional fields,
> it just keeps ptrace_syscall_info.flags == 0.  Remember, however, that
> by adding the new optional field sizeof(ptrace_syscall_info) grew by 8 bytes.
>
> What we need is to make sure that an older kernel that has no idea of this
> new field would still accept the bigger size, so that userspace would be
> able to continue doing its
> 	ptrace(PTRACE_SET_SYSCALL_INFO, pid, sizeof(info), &info)
> despite of potential growth of sizeof(info) until it actually starts using
> new optional fields.

This is clear, but personally I don't really like this pattern... Consider

	void set_syscall_info(int unlikely_condition)
	{
		struct ptrace_syscall_info info;

		fill_info(&info);
		if (unlikely_condition) {
			info.flags = USE_ARTIFICIAL;
			info.artificial = 1;
		}

		assert(ptrace(PTRACE_SET_SYSCALL_INFO, sizeof(info), &info) == 0);
	}

Now this application (running on the older kernel) can fail or not, depending
on "unlikely_condition". To me it would be better to always fail in this case.

That is why I tried to suggest to use "user_size" as a version number.
Currently we have PTRACE_SYSCALL_INFO_SIZE_VER0, when we add the new
"artificial" member we will have PTRACE_SYSCALL_INFO_SIZE_VER1. Granted,
this way set_syscall_info() can't use sizeof(info), it should do

	ptrace(PTRACE_SET_SYSCALL_INFO, PTRACE_SYSCALL_INFO_SIZE_VER1, info);

and the kernel needs more checks, but this is what I had in mind when I said
that the 1st version can just require "user_size == PTRACE_SYSCALL_INFO_SIZE_VER0".

But I won't insist, I do not pretend I understand the user-space needs.

Thanks!

Oleg.


