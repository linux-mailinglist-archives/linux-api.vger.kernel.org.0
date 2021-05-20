Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1C389ED0
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhETHWN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhETHWL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 03:22:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1DC061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 00:20:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4844715pjo.0
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 00:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=1a8BUw6AmeU9jhk87302iJ+1G3wTSv+KqaggD9Jw1iM=;
        b=CKkNwQcLmL9XT1YxqvpiT4WQqkLq6fl1hYX4Xob56iKlCTwzeudFh6yA4JqDw/4gq5
         q4PmUVIZMDmsWnktlag2cO+kRIUupe3EWQAdh0Gem92MgNjItFfQpEMUS1Guyvbjqyyz
         OS9ztbZmm/tU23FsNi2NFVFxt2CjJmNNNRMnYQhMqZ+vZGKiQQVN3glRMc3AbcNOqVN2
         nMO+tqq1T1JKkUv6cnJfuc0AqgOxCSp5ndUC6ksSjljp8jmU2tFbsYEai0OXcQrRDt7p
         mgQAS2D1jQzqVVDsns0EbJnj0iHP0ScoV8y8qLBdxRs+O9pluoBgwl5IPHcc4V9wiAO3
         Tz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=1a8BUw6AmeU9jhk87302iJ+1G3wTSv+KqaggD9Jw1iM=;
        b=luVX0RV4QmOy5ZLQUzh0tVlyE6KNXVJ8hHMc3yZtc4nnMyisvjNzGh2V0ty4/sfgxe
         4xhXy8r5lTfetDaEsE4ageCfm3t9Fke/8A17zNrldGMoHXBd/VgA29VGO/dHvN+mqqqM
         Q4eThdMXun9ddIv2t05DWknjBTS+2DIp0aGUmTE+l6LoHXljw11MqnPlhaqIpyxMBGvf
         Bp3l9V2zj9d3p6Udw7+3JW5KnwSF44ka6Xzey1954nA8w9Zg8Y8xvYnnsqqS4ZPdz0V6
         18ic1uvLO2TaImKGgvubHPhxtf1i1QcaEcxs+Nc/8u6bO73sPVnd54qXW5TnkH0tldiU
         6YeQ==
X-Gm-Message-State: AOAM532dz+LR+77bCeBxokINUarKwCtZv10wzbGj49lAbuVwGkJ5XXbI
        DGrUlYTOcsDvApC3ftNXsKsdHWxaHj8=
X-Google-Smtp-Source: ABdhPJwVWmrn/1S+RJBq0TSn/TxhD0DfUJPNLQu3qiX7wTQBZhgAvAEp7yTpQcWX0uzXnRImCKzY1Q==
X-Received: by 2002:a17:902:e812:b029:f0:aa50:2f1d with SMTP id u18-20020a170902e812b02900f0aa502f1dmr4167957plg.79.1621495250742;
        Thu, 20 May 2021 00:20:50 -0700 (PDT)
Received: from localhost (60-241-27-127.tpgi.com.au. [60.241.27.127])
        by smtp.gmail.com with ESMTPSA id l1sm1271991pjt.40.2021.05.20.00.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:20:50 -0700 (PDT)
Date:   Thu, 20 May 2021 17:20:44 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Rich Felker <dalias@libc.org>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, musl@lists.openwall.com,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <1621410291.c7si38sa9q.astroid@bobo.none>
        <fb9b6a6099855bd00efc6ffe540ccad14dd9a365.camel@infinera.com>
        <1621413143.oec64jaci5.astroid@bobo.none>
        <20210519143836.GJ10366@gate.crashing.org>
        <11d62aa2488e51ec00fe77f24a1d7cdcc21af0b8.camel@infinera.com>
        <20210519152205.GL10366@gate.crashing.org>
        <adec4377144a44b6f9ddd10c1b5256b80c9ceb50.camel@infinera.com>
        <20210519234846.GS2546@brightrain.aerifal.cx>
        <20210520010612.GA25599@altlinux.org>
        <1621478448.743zqcrxza.astroid@bobo.none>
        <20210520025948.GA27081@altlinux.org>
In-Reply-To: <20210520025948.GA27081@altlinux.org>
MIME-Version: 1.0
Message-Id: <1621495199.91bc4mp4tb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Dmitry V. Levin's message of May 20, 2021 12:59 pm:
> On Thu, May 20, 2021 at 12:45:57PM +1000, Nicholas Piggin wrote:
>> Excerpts from Dmitry V. Levin's message of May 20, 2021 11:06 am:
>> > On Wed, May 19, 2021 at 07:48:47PM -0400, Rich Felker wrote:
>> >> On Wed, May 19, 2021 at 06:09:25PM +0000, Joakim Tjernlund wrote:
>> > [...]
>> >> > W.r.t breaking ABI, isn't that what PowerPC is trying to do with th=
e new syscall I/F?=20
>> >>=20
>> >> No, it's a new independent interface.
>> >=20
>> > Unfortunately, being a new independent interface doesn't mean it isn't
>> > an ABI break.  In fact, it was a severe ABI break, and this thread is
>> > an attempt to find a hotfix.
>>=20
>> It is an ABI break, that was known. The ptrace info stuff I fixed with=20
>> the patch earlier was obviously a bug in my initial implementation and=20
>> not intended (sorry my ptrace testing was not sufficient, and thanks for
>> reporting it, by the way).
>=20
> Could you check whether tools/testing/selftests/ptrace/get_syscall_info.c
> passes again with your fix, please?

It does.

Thanks,
Nick

> If yes, then PTRACE_GET_SYSCALL_INFO is fixed.
>=20
> By the way, kernel tracing and audit subsystems also use those functions
> from asm/syscall.h and asm/ptrace.h, so your ptrace fix is likely to fix
> these subsystems as well.

