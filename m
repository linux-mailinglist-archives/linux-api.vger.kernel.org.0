Return-Path: <linux-api+bounces-997-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C3857D33
	for <lists+linux-api@lfdr.de>; Fri, 16 Feb 2024 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B2E284CB4
	for <lists+linux-api@lfdr.de>; Fri, 16 Feb 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DD1292D0;
	Fri, 16 Feb 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA7+kPop"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299B7869A
	for <linux-api@vger.kernel.org>; Fri, 16 Feb 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088872; cv=none; b=oy6Uv/s5l4gtCH8XaMEE5YpLw5T6qsg/QFfb8ev4/LpxvdARJ+sS0ZAo9+V7ntyGA/k5lGZe1IYrg3yYplE74fthQp7xRQKNW7OlNOJvxaa6d5/0p+q4H6R37fW9jbGQ5SJ4b5mW6FKU9izsrxpkrs43Up2HFekStGAWIN6A3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088872; c=relaxed/simple;
	bh=pPG3R/OErTmWA1YaPaPl80i0l8sVL+bI6w7kjgG1990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGXmHHoUpVQl5jsb4G4gBggH07erwm2DJCWDXiXwMgFILbt7JNScZZmL0wLYHj/4ySOc8QG90JYWo0BX84TMeu+dfq3CcxIe0SAEvVi6xzOwBneL2c7TFVgNyFMsDxdcG8gZbQaM0qmjKz+KgYdCk6ShVLv51hnhx1PlQsvvINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA7+kPop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708088869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEE5vefXCxxll9I1yPyvGhbZ4bDFBlmFBtJG7JnBVrQ=;
	b=bA7+kPopB/agPkcrEvITHQ3Gcm/ZySjM21suSDR71n8MKIGwuhXNLous5ZeKQYANJKfLth
	S+jedeY6OILV8Xwfgdf/HjacGU6cUQJd5n9EJ33nD19bAUPGgwfNfpoeebJ+Z3hLSK40Rb
	VR+gFJlS1Z+QZTjNOTYCdhEhYsbWOGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-S_YwwsXwMYGM4fFK26JqPw-1; Fri, 16 Feb 2024 08:07:46 -0500
X-MC-Unique: S_YwwsXwMYGM4fFK26JqPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0451685A589;
	Fri, 16 Feb 2024 13:07:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.116])
	by smtp.corp.redhat.com (Postfix) with SMTP id 27FF52166AE5;
	Fri, 16 Feb 2024 13:07:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 16 Feb 2024 14:06:28 +0100 (CET)
Date: Fri, 16 Feb 2024 14:06:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240216130625.GA8723@redhat.com>
References: <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-albern-aufwiegen-1de327c7dafd@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/16, Christian Brauner wrote:
>
> On Wed, Feb 14, 2024 at 01:36:56PM +0100, Oleg Nesterov wrote:
> >
> > and I am not sure that task_pid(current) == pid should allow
> > the "arbitrary signals" if PIDFD_SIGNAL_PROCESS_GROUP.
> >
> > Perhaps
> >
> > 	/* Only allow sending arbitrary signals to yourself. */
> > 	ret = -EPERM;
> > 	if ((task_pid(current) != pid || type == PIDTYPE_PGID) &&
> > 	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)
> > 		goto err;
>
> Honestly, we should probably just do:
>
> if (kinfo->si_code != SI_USER)
>         goto err

Hmm. This doesn't look right. The purpose of the current check is to
forbid SI_TKILL and si_code >= 0, and SI_USER == 0.

SI_USER means that the target can trust the values of si_pid/si_uid
in siginfo.

> +		if (kinfo.si_code != SI_USER)
>  			goto err;

See above...

Oleg.


