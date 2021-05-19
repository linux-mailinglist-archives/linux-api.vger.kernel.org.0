Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F43888C8
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhESH5C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 03:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbhESH5A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 03:57:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F9C06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 00:55:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso1280897pjb.0
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=GmmNZdO9FoNP+URm8CVNoqZEAE+6NAUH5yKD/2Xach0=;
        b=NyS2LXGAiHslbRFa3JaBrL6GdYzEAePCOhxgssi2OqhPB9zLNDzxhhdeGmTmPBYmuY
         DILDDwQ82iet2ZqLY6EjMRf7yeLuW4RAtIDgB6fwJoROLEt8NoCktz98mycuYD9yjEW+
         1DOLY8avYf9lRpAfzZUVsTAnUmSVcp6YkDRcc5FtrU+gpkaX6vERiE+sPOL8yLbR6cm6
         D4f6Gu8f1H48fjgcCaVXOBI2XKl0tSHap1ewqmumUz0Un8j68P8RSOVp0Ib+C2/2DZ4/
         +cBjE0r2BnGnGvAoYzJIF/NS7j0WUmNdycOdY/+bq6vWJFfV5eurfucDM/4B+UN97kOx
         Pzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=GmmNZdO9FoNP+URm8CVNoqZEAE+6NAUH5yKD/2Xach0=;
        b=mMxpGp3I66txqVKKujoTBCw5QYZd9BRJc+L5lDh/KbJAaT1OutFpgrkx8p5IeIidaQ
         AOB3XVrzHDAZBZh/JtzSdHoo5nuIDQW5qzvXa35Fm71NSjplGirh3wm9QuVv5KtU3S4z
         remQHgTVYkUv9wnFLKydfqtFiqDcVvrYIxTKahK7wWJoN0zaJtb4sYHaa8lFUdMm3nXS
         4HyBGVVbb7kzeO7JHKQQ/SuF/lQx6NCGLdva3quOkF6egTaLF2qC7GY7PBBQfyhfL6XG
         /D5fMt1pbE0WvFBIal4jVxYMHRzrDuuNtBtT5g3uQ+So91ju41Su0AVFZHePtn4pQZk1
         hhqQ==
X-Gm-Message-State: AOAM533EEA7QEMUXVWNmVvH9nkuOmIEo71CeCZq/8VlaQXaftfcjlpJM
        KRVgrlPQcKX7ijJ7r1Bjh/OtbdS+hto=
X-Google-Smtp-Source: ABdhPJyxixB1OI/aDHOrXuCSWxO1sTnVnOdgtw1LfeEEZG1X/SV2T9BzrHfTlNyK4EM1OAwePFLTdA==
X-Received: by 2002:a17:903:20cc:b029:f0:cc11:51c2 with SMTP id i12-20020a17090320ccb02900f0cc1151c2mr9571799plb.32.1621410941336;
        Wed, 19 May 2021 00:55:41 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id c191sm5878014pfc.94.2021.05.19.00.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:55:40 -0700 (PDT)
Date:   Wed, 19 May 2021 17:55:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc:     "libc-dev@lists.llvm.org" <libc-dev@lists.llvm.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "musl@lists.openwall.com" <musl@lists.openwall.com>
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
        <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com>
In-Reply-To: <9b5ea7059c5a5d4e9ccccd7d73ce2c66b2203f52.camel@infinera.com>
MIME-Version: 1.0
Message-Id: <1621410291.c7si38sa9q.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Joakim Tjernlund's message of May 19, 2021 5:33 pm:
> On Wed, 2021-05-19 at 02:13 +0300, Dmitry V. Levin wrote:
>> Hi,
>>=20
>> On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
>> [...]
>> > - Error handling: The consensus among kernel, glibc, and musl is to mo=
ve to
>> > =C2=A0=C2=A0using negative return values in r3 rather than CR0[SO]=3D1=
 to indicate error,
>> > =C2=A0=C2=A0which matches most other architectures, and is closer to a=
 function call.
>=20
> What about syscalls like times(2) which can return -1 without it being an=
 error?

They do become errors / indistinguishable and have to be dealt with by=20
libc or userspace. Which does follow what most architectures do (all=20
except ia64, mips, sparc, and powerpc actually).

Interesting question though, it should have been noted.

Thanks,
Nick
