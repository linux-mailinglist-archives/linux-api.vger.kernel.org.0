Return-Path: <linux-api+bounces-987-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BBC8559AE
	for <lists+linux-api@lfdr.de>; Thu, 15 Feb 2024 05:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0961C233B7
	for <lists+linux-api@lfdr.de>; Thu, 15 Feb 2024 04:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA458F4E;
	Thu, 15 Feb 2024 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e8lXUavu"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91817C8
	for <linux-api@vger.kernel.org>; Thu, 15 Feb 2024 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970457; cv=none; b=R1QaaaxZcKV/HY92G5pPZqEmv4oIjX/vHYJVMajuOfR+HsBgUBH5gEp2F7xs8seL+smWmtIzJ0p/fV/Ac4lthb9l+RT70DH0EqS8lIga1wleYV3K/LxAW4/WewrQ7bGJa7dfI5dAJ98p/qHCYD+pp4sKpTs/RvFjeLDiWie7rrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970457; c=relaxed/simple;
	bh=GWOm6iTHQSxlAV00u0AtMXXNvT0ukROOnxRlWLQBnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3akjax+PS86RGArq40ctPnaiqjd6IpbAg3mM2adJWl7qf2DRRbRPe/ZePOLpJ7Jz9qFtEyUULQfm+MOLab8VEvfN9V4Jp4iV2syfnJuXHof52v1NZ24xkELfM/bhKaxUjLUd63PDxpNbUG8y28efEU1Zf6rE92sFpBww0Gu4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e8lXUavu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60790e62f90so4917337b3.1
        for <linux-api@vger.kernel.org>; Wed, 14 Feb 2024 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707970454; x=1708575254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWOm6iTHQSxlAV00u0AtMXXNvT0ukROOnxRlWLQBnes=;
        b=e8lXUavueGEtQ052xskHfhiRuD6fcWC9q0nypq2em8yk44LfdiIOeMon5dP6tVDSmp
         muk61PqEbQn2RdE1g07QpIHTC0yWlHw/4vkr3mBTb1RVKS9U7+lOXjgiFU5pOifgVarY
         i0FN7l+gSLKcYIux0MBLYqx1U6hADnhbx65aqTYrwxsdSxgEMFy+C4kakFE2Fe4THVQL
         Bm5qN9rC3Xq6PuhNLg+puKZdRtPAXhfa7zsiq4Jz4lzuJVyZl+Qq82AegRkp/NiSvCrf
         qydNEPrlWma7uRTmRNAlvW3Pl5+CPYKraeXyYIxdpCYmLH226rSAZEovvPGLXeTnwdFC
         XkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707970454; x=1708575254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWOm6iTHQSxlAV00u0AtMXXNvT0ukROOnxRlWLQBnes=;
        b=uCpl2PuNlSF8npzvaU+aw+pYlXkujjD/LQn0ERKrsKHHzRcHOfsNJUG78Di84ahaM7
         8qiWbGBY8iBQk5T6fStD4pvhoZpa9aXH45HWXqViDEKi6vZFjDMpvk/M3sNiu2rorJRX
         IT25sasvsByxMg1BVShY3bmoxEeZx5Kkh0iGTIxmrp1KnXFHx/tmyl1ovlu4mN6lDrgn
         5Zq2W+t3hBO2+OfCGNXwxkWeA5NVPzm10NyifRz9ulEYivh7+b2HUEV6VB1D8Sk7zj4l
         vgukXwSgXQyLdAkCyI+PoFLv+J+OMboXX18stzBNYQOngYLqbBdc8EUWyxrBD/ZLGTPm
         p7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUa6Ohq6/SAee9xsULSReYobstMuwsjnwTh2OsPuPnp1kzGSuHlFFWnxOhaPJkoBgkQk1VtJCBrEyMYtqRBpRdyW7Nv1xpkKTI
X-Gm-Message-State: AOJu0YzsKr1ey2mJeeedZED9r07a7Ecy2JZQ33duwJ2WkqMzfBe4SWqR
	cKHdz1zIp4fODNer+/G5gR9grHVuNdj2BbzFbzF++adyU1LalxdV0KRmlPhvK9z6VdWpx4A8xM/
	Nis1ag4Y4hiKxt9iffMLHnRwfq8JvXXtYDzxfRg==
X-Google-Smtp-Source: AGHT+IGli7KTi+oTy9r7ChRsf7LElU9R7/7skdQucQvdahbi2P7ubWtsnls70yhwQwNOiEhVx27u8rRA0Vp4oT8C8S0=
X-Received: by 2002:a81:4886:0:b0:602:ccb6:5da6 with SMTP id
 v128-20020a814886000000b00602ccb65da6mr601453ywa.35.1707970453767; Wed, 14
 Feb 2024 20:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org> <20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 14 Feb 2024 20:14:02 -0800
Message-ID: <CAKC1njQ26nN8ZYLvBYd8=vEbSHLC1aH-aOCoDdf35LhEQxNdsQ@mail.gmail.com>
Subject: Re: [PATCH RFT v5 3/7] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, jannh@google.com, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Since multiple architectures have support for shadow stacks and we need t=
o
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Deepak Gupta <debug@rivosinc.com

