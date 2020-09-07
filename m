Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70D025FBEC
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgIGOR5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgIGOQb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 10:16:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F161EC061575
        for <linux-api@vger.kernel.org>; Mon,  7 Sep 2020 07:15:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so6539410pfn.8
        for <linux-api@vger.kernel.org>; Mon, 07 Sep 2020 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=pMKtnu62KrFlClqQRGBjCSOknfMgdgn3+wr6HnRppNY=;
        b=D64xvzFLBlnNeTQkT8TNQY9QSEEmAeebO85yfOC8NPD1qtRe6ZhnRviUtvOdxf7zNs
         K5w9Tc56LdukXCGiVOV0RnjgFVbBUOBeD0YvkNdcyIRUZqHMAGLUalClCgCTARRRghvX
         0syIVDRXlYXf/9UkCbwkjho2LiGFWDgF0jefQzrfll1AaP8/1iF03O7LOXwtlHzPC5o2
         I7l8npCZsBDhjEaTB0HUB7llatpo1fnrqibiAczZYpjt9RwxiE1/4IJ0nbgeUY7dfu0K
         DdpHrv1SwsxdcqShg+ockpxLo9zrZWTK4NGRi2HGlIb9t7VQbc2feZTADbtP9rlW2EI0
         cR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=pMKtnu62KrFlClqQRGBjCSOknfMgdgn3+wr6HnRppNY=;
        b=Ze9/sGMEG78MZPGv4ZTVyWvmznTd0rsel8+nOL0ldcQlk8Ag3tyi33fjyHY63T5ltP
         0DvJlzWlYQK9mxAZ5H6yEryFz6dv1sH2k01uQbrwUbOA1EdZ6AR3C/XyLrTEGhrXJ/8Q
         vZrkmHaFTO/MipNe26gCiaHDLJDnWjHND0EG0wcM5ANwxitl9i+97f4k5ib9Ya+h6Rd8
         GbLeU4iruYAhUy+sHrn0cT3NjFch7urTpsxnP8wUNbl+lbbRWZTaycKyfso+Di+gfqhD
         UNrWHmw4pNPyq7P8uDFjTMjw7CTUgPN+zfBykGaVr8B0LuctxuHTBoSVOeaTbBPPo8Uf
         wLow==
X-Gm-Message-State: AOAM533CGOdB7bli12q8tUc8ZWsxzQMWpzCKdT3PejOSaJBzZvMlEQAr
        AQe6FMw3/oPgc4zALHvfVZOboA==
X-Google-Smtp-Source: ABdhPJxDzNPgTKU+KaHZmsuByNel5l69rVNLnkpVmRixOH4K76E96CSThsbS7P+Xe0BpNllo+5a76Q==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr16395793pga.56.1599488154774;
        Mon, 07 Sep 2020 07:15:54 -0700 (PDT)
Received: from ?IPv6:2600:1010:b025:3136:b1da:8d24:b138:6fff? ([2600:1010:b025:3136:b1da:8d24:b138:6fff])
        by smtp.gmail.com with ESMTPSA id m25sm15245324pfa.32.2020.09.07.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:15:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for common syscall entry
Date:   Mon, 7 Sep 2020 07:15:52 -0700
Message-Id: <0639209E-B6C6-4F86-84F4-04B91E1CC8AA@amacapital.net>
References: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
In-Reply-To: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
To:     Christian Brauner <christian.brauner@ubuntu.com>
X-Mailer: iPhone Mail (17H35)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Sep 7, 2020, at 3:15 AM, Christian Brauner <christian.brauner@ubuntu.co=
m> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Bertazi=
 wrote:
>> Syscall User Dispatch (SUD) must take precedence over seccomp, since the
>> use case is emulation (it can be invoked with a different ABI) such that
>> seccomp filtering by syscall number doesn't make sense in the first
>> place.  In addition, either the syscall is dispatched back to userspace,
>> in which case there is no resource for seccomp to protect, or the
>=20
> Tbh, I'm torn here. I'm not a super clever attacker but it feels to me
> that this is still at least a clever way to circumvent a seccomp
> sandbox.
> If I'd be confined by a seccomp profile that would cause me to be
> SIGKILLed when I try do open() I could prctl() myself to do user
> dispatch to prevent that from happening, no?
>=20

Not really, I think. The idea is that you didn=E2=80=99t actually do open().=
 You did a SYSCALL instruction which meant something else, and the syscall d=
ispatch correctly prevented the kernel from misinterpreting it as open().

