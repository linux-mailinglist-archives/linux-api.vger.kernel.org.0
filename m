Return-Path: <linux-api+bounces-5084-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC00BCDA48
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EB324F2ADE
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34DA2F745E;
	Fri, 10 Oct 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAxjFQoS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3ED2F7456
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108275; cv=none; b=N0HqOmqHR4lrlAoxbjHTyHMVnbSMfck+PgpDvvzTbZEGw2IAP5dZi2Ki/UYMcdQbAc/IZ5U2kVvae/+ZBX9+6nM2yVPKlWZUoUfq6h6/I42OhP5u0KGFdDq8cWWZR2P149mcEXKfX3z7rxiPpX4vGCfgD8ObiclKr0gSCg9OdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108275; c=relaxed/simple;
	bh=QQVYa4ebCX8v8+c+fDYRRGNE0jM/1QXakKg6oLLEBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cogFbTRZyR04fVjnE00wmeroQ19Stnwnh5fEAQiTDY/G6megDYnxeKnbI7OuqGzw9uj5oPe6CoYZvPdoY4Yx8dElVhExmMMGx1ayx8gVK1aUHunLiBQ3bqdz9NOEMdDEQu7EG6KNULIxlF1QfS8RxjHAwSxQAwjEi5bhIboncbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAxjFQoS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78115430134so1537922b3a.1
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108273; x=1760713073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=CAxjFQoS/jb4TMgFpWob4hN+EWlm06MxLcWp3sBs0aS+t66J7GzQ17+8CC5dQwgoOM
         ZUQ8dm/H5l8PXcTNEoESIIFiJZOHdZ/papHwKdTEZULt3l4v4l6vxRzRIZI7gjBbOmvH
         Sdg5M/SwQAnA/0tjDna5p2Ha6K+jSMzyXKknBq6GLTlBwpmmdCNh2HWbT0p5cNFF2Qnu
         angK9QQL0nwYh+COink+kqkvgcNAK+rxsap8OjiiFjFojOAJdUzrMY36sVd3HDGbrU29
         XNdsscGIbv7ujwfp8M6YOntytm4sAPNv236n/3iDtEV0ZPi8qxMYoD6Yz7UnKMv0dMON
         8jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108273; x=1760713073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=BYTrzei2mk1s9pa6eLP2CI54IF9c6tIVi1dr1I4C1dXcwqRI4dzSWVjjqfr7KJj0Yw
         ghAOOW+W66jokQGYGkFIUuRkSGBjeRQrjhnx1ZWjtziyJnBUqNL0S6LrJ2BqTQ/caYye
         oh0xq4g36+JRtzrBmK/3ZdhWw1sj3+y4nO3GfXb4GiGJclQ2fERmiCGXh61RV0v5rivA
         iJIJ7RL/g1887Y3CCEUFfa/3q8vG8/n3E40Y9+DdumtPb8Zy5s5/InacfyEVHmSfT0A0
         nx/MoGzDlvhcae4Ka2rEph2xKErysC9epALol9lwo39rxmzkULvBrJJPpohj3fp51pTj
         qB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/7LnztB8HY86e6Ls2DqWiNunIrrHWzNO9TyjKQjCNl3b/JRy1upwN/luN+ehEQfOLjiTtZ8eFprk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb0WJxZiO1GRjDbaWbH6uq3RS7ViWg7oi5n+WvXH/9JYS6IBBa
	4qAAEC9jAM4X0gEySqTSmDv/fmow4qITp8sP7PIZ67x1yEto6G3wi3N1564b43WWsmSUDsa3Txu
	bn56RzRRyx8/ncd7RUPHUhCh8BXVKNuRVbujwsiQd
X-Gm-Gg: ASbGncuQ1gR0zMGbrv1TowuWtmi6YB+lZGUfltGhAK6KILhGdU+pC3sl5qUpv00nfvl
	LtlV1I7x7Bj/yeleK3C1Xr88MFtyueSCko3w7tdqzDFhxK8/6Pmp4SSEbTHivTRLN+EdYFy9yQ7
	RvKrVVpLR6/2CgFzRzG1B8XR94h/RosLgjfKByLFegyeJSm84Sk1phB+0SeASdi0uCklE6+15qJ
	Sc4aWttCJm60Mw8Al2w9EUwdO59CiC3zqWn
X-Google-Smtp-Source: AGHT+IHkK8Gm9viP+PnMJqCf6YwcaiPSZAhk2njG3CWT6nK+53DU2FspPpHEd0UmuOb2fdMKjhpGzmFzl8fSVbMyvcI=
X-Received: by 2002:a05:6a20:6a26:b0:2e3:a914:aab1 with SMTP id
 adf61e73a8af0-32da83e3df1mr15879251637.41.1760108273442; Fri, 10 Oct 2025
 07:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-5-maxime.belair@canonical.com> <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:57:41 -0400
X-Gm-Features: AS18NWDDlD9d-obeXSKEgVeXrkg3pQGOfVLXHTxpEsZnDxFwMdZ6CYaIkCq_crw
Message-ID: <CAHC9VhTSsUf-XJTNSxs-7DeAdR-0uBfL7reZnjMXhma3ZSOF+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, mic@digikod.net, kees@kernel.org, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> 2. The SELinux namespaces support [1], [2] is based on instantiating a
> separate selinuxfs instance for each namespace; you load a policy for
> a namespace by mounting a new selinuxfs instance after unsharing your
> SELinux namespace and then write to its /sys/fs/selinux/load
> interface, only affecting policy for the new namespace. Your interface
> doesn't appear to support such an approach and IIUC will currently
> always load the init SELinux namespace's policy rather than the
> current process' SELinux namespace.

I'm distracted on other things at the moment, but my current thinking
is that while policy loading and namespace management APIs are largely
separate, there is some minor overlap when it comes to loading policy
as others have mentioned.  For that reason, I think we need to resolve
the namespace API first, keeping in mind the potential for a policy
load API, and then implement the policy loading API, if desired.

--=20
paul-moore.com

