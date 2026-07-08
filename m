Return-Path: <linux-api+bounces-6800-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fi4jHveoTmqDRgIAu9opvQ
	(envelope-from <linux-api+bounces-6800-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 21:45:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1566729F7A
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 21:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=LW6ZqAC4;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6800-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6800-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0341303C66C
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4F3ACF1D;
	Wed,  8 Jul 2026 19:45:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B83A1A5D
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 19:45:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539915; cv=pass; b=MyH+aAITIpyQI1caFDgDdzfx/j7Kc0BS8dmPwP3TE3sbgBW0fpyN26VZg3u+sCsu6v3GtTJ92GlpKOXJ5Hz6XB8M8+8Wk3WQZbQGr7gkIc685QRIaw5uTPv5OFKI8eA4R10lcwknXijB+sE/vQ8rIh4X137DEnvgmdFPpAtYQj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539915; c=relaxed/simple;
	bh=JaB8MKARUyOluTUTKfGfO9Fwrtc8Ku2njk8Dxn08suU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgWL0fsEDCi/ObISlT68aAqHFywk6m/99gJsYQeh0YHqkyoj3apbVKmyrwQ+HFmBV8HP+J8fj1GfjZrkf2DiXZfTG5zcXDzw+DoLIRJUGr/a8IY1IJ2Ay92SebQT98Dgh17r8QyairQCAgLKML6zwg94UzD+kpnDh5M9UgYidk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LW6ZqAC4; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0c68aa31so7534961cf.3
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 12:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539912; cv=none;
        d=google.com; s=arc-20260327;
        b=IvhaIYHhEMZR4XJHYKfWJJmJhMxEHdkJra0ISq6QC2lXQd7ysjeqem5RIQPHARxfjs
         ZobrOAyOYt6Y567eC5XbEhOvNcOvlbm3OuCSSJoE8RDLKxpmfROzuxAZrJDxU4WjBbTz
         LEaSpa36Zi3NXyTj0+hoB1wzRDk4PMdxYUFl6ORe1yIXOTJrVCoj5tYa50wTHDuz648o
         1doSE/9YCDnxRWv1/EFKP5Nk5wj/SrqUE5XBlH4d0tY/xdl48Id9r2RV5ZP60rMD3Ovb
         vyrFQAhptVV5zDJkxpkaqYf6uZhbzERUYAXEi+SnqAQrRD2nu6s96fiw2QX9gpkEmwa+
         oLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        fh=i9jcMdoYpkXh4BvXXeh0M46scUKjEiRIrdwFpoxpW9Y=;
        b=s6zMAGCOTV6MvfUS0XqftezD45LHM5jAXOzeA2nR9xFEHHxNiKeLrbFafApuBKXmT5
         PgeDiWFakzNOWtLxmS1aSvmnZa7fGAJ/klBgJiDoHp/J44OdR+XYUZ6GJ4nUn5HQ89Us
         ksg4RaZHoe9dgpEsXgXa1CrvP/ws6GiblE+TnUat2L137b8PCl/9Q0qnymUDsVpe7yaV
         LGoPE1ZCg+YGnaAqN89Kk/qcrJdkz0O9C10dYPLjWCQ+niR7k4WBaja2bFIBMX5ulsIY
         /onNVqpS7RxYIyhH4dbsOl+k8R5NJUN3gqxN1MOnnyFd9ih8HGkuyx1BBLHy1WytLGwn
         Di6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783539912; x=1784144712; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        b=LW6ZqAC4FbxbBm8HLLrTFWWlXoMUJ9CUp2FdEycrQL1F9NefHq0xM2Dq9eWhVKBmjh
         JHlkEl3qhrEXAXf46hGh6OVto2prj6QX52fAtlIl8quaqYYWRzrpiCxZOloGEaHqXIQR
         G9sgax2w4irmb4tkY2CyHmQKLbv6l+q/VWoL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539912; x=1784144712;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        b=RnFuCEpoa7Ns7pfI/tbMFkAaYG7l/av2xq+4ghLSyNeSXRcBBUTh/R43bJs9643Azt
         Nh0Yv4Xf4vQGFy9gNiTbintB91pqGZlKtcOZzvkoaWIpm1BR14ymAQJXx3tXu+TZGJN+
         UHuYt6fRSoXm2+Gk8LDjV3AC7fa7BG9serRf9mgokx5s6fcpvRh+Gcuvl6lywx1aZiZ6
         MACUG1jalBTHcUAhXcZLSS8b4YPrxH1AOibLLSGDofai8IkUxsRWqSTvhsiJm/0uEms6
         ZRzXCqJoCWCPjbNODeZwuNKQ0EB1FSj0mmhXmR8noOGU7vZedVJYuyPEeCtbyX5/SLcw
         rYww==
X-Forwarded-Encrypted: i=1; AHgh+RphBdU75qqNDfs7tbaJCVMWT4EXtfB6Tb6bVKGuvs64RyavVnRPh1Ac5lmI2DuRKLn53qXSZk9cQi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpkvB2wQwaoGH6495EJTr8TKkGk0Edcdusu2duEXnV42u6H8f
	A4HmxLCR4jH+Mwqnfsooa1PkcM6xCowYyfIDRhZVf6JqB2bFz/MsDDngQPLqS01YW8gAiya3fc7
	unB9CcyG9lrMQa1PQC7xpxCgSFrV9bsk/Ia1R+t7M+Q==
X-Gm-Gg: AfdE7cmHHWez63A37hPOXTf5ksBCmgVTpQ9IwYdG+Yh0kf0OPX9DuJPr9ZaqRILxlLV
	3/Zl4cRJ5Rx7UudlB6PlIMP3x9vYQ0lAmUjW7IdKiZumiqlZu19M6gDs9AFvfA82Trg4fw5GtGl
	8vf03OJg2Ek1uQHs3evFoXQwtIPHZo8XYGaMy2Kp3ZRbh6GjjDNzu6dNnDBldIPZw0eDjfMa/2/
	xc9uy/cPjvXyPUTxm3wehsmVz5gccvnJsB3x8iQSfVAPjuhi+EQRCAxOEcd5p/apv3iz+5zSVry
	z7zlHF5D8yHplDzzRRMyupWn9NrjN2HDAV6zfQ==
X-Received: by 2002:a05:622a:2282:b0:51c:4eb:b586 with SMTP id
 d75a77b69052e-51c8b2bcca6mr44081721cf.3.1783539912501; Wed, 08 Jul 2026
 12:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
In-Reply-To: <87o6gh79yi.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 21:45:01 +0200
X-Gm-Features: AVVi8CfEBqDFsxEsCKynN2toUTD0jqsYUgCkXMmD75nSowC3aB39c38nRzYyz0U
Message-ID: <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6800-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,zeniv.linux.org.uk,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,szeredi.hu:from_mime,szeredi.hu:email,szeredi.hu:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1566729F7A

On Wed, 8 Jul 2026 at 17:55, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >
> >> Amir suggested to add that functionality when I've asked for some
> >> feedback before sending the patch here.  I am fine to drop it if this is
> >> the consensus although I see its utility from user space.
> >
> > How about a completely different interface:
> >
> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags);
> >
> > Enumerating layers would be as easy as passing an index stating from
> > zero and stopping when -ERANGE is received.
> >
> > It would work for all filesystems that use files as options.  No more
> > fs specific ioctls.
>
> Is a new syscall really justified for such a narrow use case?

That's the reason I advocate pseudo fs based solutions.  Let's see, we
had a proposal to use openat(), something. like:

openat(base_fd, "mount/options/lowerdir+/0", O_ALT | O_PATH);

Meaning that O_ALT switches to an alternative/meta namespace that is
based on the given fd and in that meta namespace the tree under mount/
represents the attributes of the mount that base_fd is on.

See this post from Linus as well:

  https://lore.kernel.org/all/CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com/

The statmount api took a different route, but for getting an O_PATH
file this would be a very natural interface without added syscalls.

Thanks,
Miklos

