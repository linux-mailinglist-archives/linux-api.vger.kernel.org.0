Return-Path: <linux-api+bounces-3044-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB8A15212
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAAB169867
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E817C21B;
	Fri, 17 Jan 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHiiO00Q"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFF13B2A9
	for <linux-api@vger.kernel.org>; Fri, 17 Jan 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125198; cv=none; b=cxEeQXITkx4C1YfV9I+Y6OLp40A19GRzkm95JDPejHn0B4jjpe4iMUp2Wg2WsdB7TcQmTGEM3JkUJUDn1v57jQCZGh1bYKVXGRMhgvuN6E7VXAyJUoBt6HCxkGmUvPwIWJTT4hRJriEAbA+BHUZid16qn2L4XtVmXJzL2WiknWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125198; c=relaxed/simple;
	bh=79F3g34ZyoaizTkt+l5N505iuzpx8fOb+zBwSMSnXR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkDuQV1KgyTvaQS+YTGeslNcF9CItnBkip8k8IroRZiYLubH1qEudiKbi6rg6dBJnEAtbDWMH9PzjZzCb6QdEamucuLVBpbj8rmg6VwuV0CzsFyUqt33G6Q5gfn7yIbcF2Pv8YOtLmQopRZgdxfntYJl67x55SbrSmRuXnXHZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHiiO00Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737125195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1NxxkV1zamccnT9i2dReMawvJ39MRoDX74HC64YTmA=;
	b=ZHiiO00QItjleYVVHtbv5uGwqpSBn55WU2W9iIY1BXhfNdQgoxuNCZJAuMNKb1E1ElocR0
	FNTec0o+8mld8PP6VwnqiRXex4vHxkvPQS4xg8t6blubnPP1G4OOgUbqnaimjdDks7CUXI
	R/iHa6n0QTYG9tcPXgMzucUt0WPTML0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-gz4dCDV2Pt-ZouLUoFI3JQ-1; Fri,
 17 Jan 2025 09:46:30 -0500
X-MC-Unique: gz4dCDV2Pt-ZouLUoFI3JQ-1
X-Mimecast-MFC-AGG-ID: gz4dCDV2Pt-ZouLUoFI3JQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A14C7195605E;
	Fri, 17 Jan 2025 14:46:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7393919560BF;
	Fri, 17 Jan 2025 14:46:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 15:46:03 +0100 (CET)
Date: Fri, 17 Jan 2025 15:45:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250117144556.GB21203@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116160403.GA3554@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/16, Dmitry V. Levin wrote:
>
> The idea is to use "op" to specify the operation, and "flags" to specify
> future extensions to the operation.

OK,

> That is, the zero check implied by copy_struct_from_user() is not really
> needed here since the compatibility is tracked by "op" and "flags":

OK, but then why this patch uses copy_struct_from_user() ?

Why can't we simply do

	if (user_size != PTRACE_SYSCALL_INFO_SIZE_VER0)
		return -EINVAL;

	if (copy_from_user(..., user_size))
		return EFAULT;

now, until we add the extensions ?

Oleg.


