Return-Path: <linux-api+bounces-781-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA91844778
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 19:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D41F26F72
	for <lists+linux-api@lfdr.de>; Wed, 31 Jan 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA022095;
	Wed, 31 Jan 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg84FDUa"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4D2135A
	for <linux-api@vger.kernel.org>; Wed, 31 Jan 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726995; cv=none; b=A8tFSbJMs+/GOwDS9vUZ7SAIKCJITOSXhBuEnqHE5QfOCFAF7stvqvFnQZsj7u5tIiS1rgXbNXTQPQwMmBmxf4HkZTHHWORLhrL/JCZV6QiG3fq5PcNLdKQWll73oLwfcQ+H8M2fXGbM7gPuqIsDG5TRhqY9IXdFjx5jn1GjuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726995; c=relaxed/simple;
	bh=X4u+dQV5QUMk/zja0MJJBmXhJnm57hYRFF/uFj0w7ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0fq/Nryri+YuaNcyLh7jXGfoVT1KZwpsO2XEjs/GjhLRnQcgh7NIm1vNP6d4dUxSDNS6S155JenE/6UR5AWOg/9kyTTFjwjc3z93aG1PjhgQUKxjbmMU4rEe1HhAed8t4A64TJYLq5H5zpgrwEyC5O/+G5u3vUO2LwKNOlwKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jg84FDUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706726992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9U8CKXhwM8+HNsv/ZLK5nhFsmc+OFbd5U+w8VnN6xI=;
	b=Jg84FDUapICGA1p6YwJ9aaaOiAvqSbNl5lbM//iwhgTGm7TM7BOIddQggIQ6Tzlqn+mwLO
	nKo1O08HGFPUgoDt3/DOK0G3BL5h8+18hfX6hvM8YL5A24s9u0mKlBdUDCacuPLYeG15Mx
	nl0efPoHzkPSAa//J1evLc2WQUU2K4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-KU-iabKxMFWAVmHrBJ0N5w-1; Wed, 31 Jan 2024 13:49:47 -0500
X-MC-Unique: KU-iabKxMFWAVmHrBJ0N5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76D6B1064C64;
	Wed, 31 Jan 2024 18:49:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id CAC2FC1ED63;
	Wed, 31 Jan 2024 18:49:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 19:48:31 +0100 (CET)
Date: Wed, 31 Jan 2024 19:48:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131184829.GE2609@redhat.com>
References: <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/31, Andy Lutomirski wrote:
>
> Right now, pidfd_send_signal() sends signals to processes, like so:
>
>  * The syscall currently only signals via PIDTYPE_PID which covers
>  * kill(<positive-pid>, <signal>. It does not signal threads or process
>  * groups.
>
> This patch adds PIDFD_THREAD which, potentially confusingly, doesn't
> change this (AFAICS).

Yes,

> So at least that should be documented loudly
> and clearly, IMO.

Please note

	/* TODO: respect PIDFD_THREAD */

this patch adds into pidfd_send_signal().

See also this part of discussion

	> > +	/* TODO: respect PIDFD_THREAD */
	>
	> So I've been thinking about this at the end of last week. Do we need to
	> give userspace a way to send a thread-group wide signal even when a
	> PIDFD_THREAD pidfd is passed? Or should we just not worry about this
	> right now and wait until someone needs this?

	I don't know. I am fine either way, but I think this needs a separate
	patch and another discussion in any case. Anyway should be trivial,
	pidfd_send_signal() has the "flags" argument.

with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/

Or did I misunderstand you?

Oleg.


