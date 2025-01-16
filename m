Return-Path: <linux-api+bounces-3026-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED8A13D8B
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9BB188D6AA
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18122ACE7;
	Thu, 16 Jan 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atYnuktd"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E6143736
	for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040941; cv=none; b=QR5G07jhcspXcOU8rU2X0S9OLysyT/07Cv0NCG1awtq/eoVlFSk4oUpv9F1LKLUDccBBWeKMQxV8rSBbW7/OG2h5XNXow49lAmWnLRMlAamkZzCPz648tU98b6k14mDppkUA3VRvl8KGJl0eCF0BEU5GO+SafWCPJY/gM5XGYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040941; c=relaxed/simple;
	bh=N90QLuZSJ4vVbU+nlvchOZv/IiSemS/I/LQnGuY8Rfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZDva9FqyqKvS2UlWAYcGpf4Db6+SP7mwTME1icK8n0mJSy5xhMYFu468Cs0lETjMQF0b3oKBcQ1Wy8vJ8XypKxBY0ApamZ086GjO+MfiiTrzTJGSCk5g+PHT9vglnoWIwQ1yLCpbuA1D3pblH95SMVmkrP3S4sjVkL/IaQljJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atYnuktd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737040939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a2RIxgn9luWmBRZhZkEdy6qq4cFK4/FFIfV0liW89w=;
	b=atYnuktdRzxlBpWdIcRBpsVomGJFyxF/meiCw/y+3GPelz5B1AQ3vu9X+QzDva4k8vinKS
	xfnnpcgeesZeRQ5ElWeoglWSWejdzHcSYwZ2++7XQx1R8FOvegRFvD+v2WIVFvuwwT1vYK
	D9boPzgO0ImxX5tGBmh/3JdX6lno+As=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-JYIQrn-qMliYJAtD3BCs1A-1; Thu,
 16 Jan 2025 10:22:15 -0500
X-MC-Unique: JYIQrn-qMliYJAtD3BCs1A-1
X-Mimecast-MFC-AGG-ID: JYIQrn-qMliYJAtD3BCs1A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324AE1955D6C;
	Thu, 16 Jan 2025 15:22:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AAA9730001BE;
	Thu, 16 Jan 2025 15:22:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Jan 2025 16:21:48 +0100 (CET)
Date: Thu, 16 Jan 2025 16:21:38 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250116152137.GE21801@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113171208.GF589@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/13, Dmitry V. Levin wrote:
>
> +static int
> +ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
> +			void __user *datavp)
> +{
> +	struct pt_regs *regs = task_pt_regs(child);
> +	struct ptrace_syscall_info info;
> +	int error;
> +
> +	BUILD_BUG_ON(sizeof(struct ptrace_syscall_info) < PTRACE_SYSCALL_INFO_SIZE_VER0);
> +
> +	if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	error = copy_struct_from_user(&info, sizeof(info), datavp, user_size);

OK, I certainly can't understand why copy_struct_from_user/check_zeroed_user
is useful, at least in this case. In particular, this won't allow to run the
new code (which uses the "extended" ptrace_syscall_info) on the older kernels?

Can't we just use user_size as a version number?

We can also turn info->reserved into info->version filled by
ptrace_get_syscall_info().

ptrace_set_syscall_info() can check that info->version matches user_size.

Oleg.


