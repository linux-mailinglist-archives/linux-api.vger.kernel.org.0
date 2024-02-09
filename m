Return-Path: <linux-api+bounces-899-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC084F368
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 11:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EFC1F22A08
	for <lists+linux-api@lfdr.de>; Fri,  9 Feb 2024 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2669947;
	Fri,  9 Feb 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyi28AK3"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740B69941
	for <linux-api@vger.kernel.org>; Fri,  9 Feb 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474582; cv=none; b=dhfgl1QbDYHWlTHhb3ugj/kgyyqlIclTUgFcrINL523e+LK+qdnOc/FBi0zRqXOkcKyYkoKOXABEoE0rM93DfwfZBaLqCwP6E9k2G5IR7CEGVxrsOV8m0mwVXEiSa969yQ1nVBKVMajVW4X20TAIGsIUjYALWhJyVsbdl6phxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474582; c=relaxed/simple;
	bh=HHUvxWEQeOWIogeQUKI+8xGetAxWcmQWvB4EKQ6xgDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6x0Bebz311DDAb+MFsuI0VwQZPltud3WPFH3tsyFsSg43j15R09jNrXapbMvMvPuOPF2U8bw5ZpnqFo81Ept9m5P6Entb9ZzVM4lGPGPcsFvfHFERB8jIAdrf3/eDBrcsIaCq87yj/gzgBevw+IUrOleCyLyUOpbfKT80Gpuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyi28AK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707474579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHUvxWEQeOWIogeQUKI+8xGetAxWcmQWvB4EKQ6xgDY=;
	b=fyi28AK36G7IH7pDM6lP9xgOS5jFFcyCHImkYFc4xfuy5keSGMiweqHBBeDM8+oghBKjbx
	OlfgfgTjNvR6tG0zwgT0Sroe8Q2U5gAKLTT6zYkp6Z0wOXmEuMpbrlS2WKC6DQ98unCMYG
	09qUrZjCkayB4Mu40XWB375R4PU2dj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-EERUOpjmM0WcW_tGN8tCrg-1; Fri, 09 Feb 2024 05:29:36 -0500
X-MC-Unique: EERUOpjmM0WcW_tGN8tCrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5E5185A781;
	Fri,  9 Feb 2024 10:29:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 509E82026D06;
	Fri,  9 Feb 2024 10:29:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 11:28:19 +0100 (CET)
Date: Fri, 9 Feb 2024 11:28:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240209102816.GA3282@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208143407.GF19801@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/08, Oleg Nesterov wrote:
>
> Is prepare_kill_siginfo() correct when we send a signal to the child
> pid namespace? si_pid = task_tgid_vnr(current) doesn't look right

Yes, but iiuc send_signal_locked() should fixup si_pid/si_uid, so it
is not buggy.

> And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
> just use SEND_SIG_NOINFO?

Probably yes. And even do_tkill() can use SEND_SIG_NOINFO if we change
__send_signal_locked() to check the type before ".si_code = SI_USER".
but then TP_STORE_SIGINFO() needs some changes...

I'll try to do this later, I do not want to mix this change with the
PIDFD_THREAD changes.

Oleg.


