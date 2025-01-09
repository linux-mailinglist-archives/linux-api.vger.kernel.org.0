Return-Path: <linux-api+bounces-2964-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13515A07BCE
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE25916B333
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3F21CA1B;
	Thu,  9 Jan 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br/oySSP"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772D21C9F8
	for <linux-api@vger.kernel.org>; Thu,  9 Jan 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436136; cv=none; b=JuMjAamdivf2EOXRg0idwLwgKD4c3ia17bPoBzwNI6c9EgTZvdyOauUjTJuriRgKoly/vZzVClcmGL312XmlAkBymTd6R2LlQqkWYioadZnFRUJKpEkv3ctuvPfKAuCKKfGOBAMaIL2JY6wcKl3WInFvjAVuCcwcGx6xgRcZ1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436136; c=relaxed/simple;
	bh=7hlic9DwINx0+Fa+YVaHL5quEsNHq64Ou3lt7BIaJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUPB7dMr2DTIQ7E/HWxJalwdrEV71aaOKjw9ngE0GF7pTXs6NrjjavxGSPrKLAgEN7DyHlN9Gi/qjo7J6OkeKCu2eAKjDUZnPnv15GdYORkNkyb0qoZqRisfJzzSPCAUp1vKVNqsbnn+nKg89BzUdOTkIfvOHtvRmRtgKMmEisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=br/oySSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736436134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4GyuqGemjDMwI9jFcgvvjeAAXquBzCIFaaBO/jzUZU=;
	b=br/oySSPMEuWdnFKPL/rj/qJfMZfsiLpF6hHe3axyCnl9LflLsMhGS4QRfyJIooyfvY2RG
	moEFZBHyVtx07jhoaRKkUXhv5gk7LbeieUdMhZDaj6SxemOC9CDD+QbjridZyS/stmRIMu
	0BZkk1zoloEgoqrBzj+wJf7Em7hFww8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-Z0zYW1GgNmqjniSPM3Y2Bw-1; Thu,
 09 Jan 2025 10:22:10 -0500
X-MC-Unique: Z0zYW1GgNmqjniSPM3Y2Bw-1
X-Mimecast-MFC-AGG-ID: Z0zYW1GgNmqjniSPM3Y2Bw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E4E31955D80;
	Thu,  9 Jan 2025 15:22:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 09AB430001BE;
	Thu,  9 Jan 2025 15:22:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  9 Jan 2025 16:21:43 +0100 (CET)
Date: Thu, 9 Jan 2025 16:21:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250109152138.GE26424@redhat.com>
References: <20250107230153.GA30560@strace.io>
 <20250107230456.GE30633@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107230456.GE30633@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/08, Dmitry V. Levin wrote:
>
> +ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
> +			      struct ptrace_syscall_info *info)
> +{
...
> +	syscall_set_nr(child, regs, nr);
> +	syscall_set_arguments(child, regs, args);
> +	if (nr == -1) {
> +		/*
> +		 * When the syscall number is set to -1, the syscall will be
> +		 * skipped.  In this case also set the syscall return value to
> +		 * -ENOSYS, otherwise on some architectures the corresponding
> +		 * struct pt_regs field will remain unchanged.
> +		 *
> +		 * Note that on some architectures syscall_set_return_value()
> +		 * modifies one of the struct pt_regs fields also modified by
> +		 * syscall_set_arguments(), so the former should be called
> +		 * after the latter.
> +		 */
> +		syscall_set_return_value(child, regs, -ENOSYS, 0);
> +	}

This doesn't look nice to me...

We don't need this syscall_set_return_value(ENOSYS) on x86, right?

So perhaps we should move this "if (nr == -1) code  into
syscall_set_nr/syscall_set_arguments on those "some architectures" which
actually need it ?

Oleg.


