Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3F1012C9
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 06:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfKSFHz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 00:07:55 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46697 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfKSFHz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Nov 2019 00:07:55 -0500
Received: by mail-pl1-f173.google.com with SMTP id l4so11074055plt.13;
        Mon, 18 Nov 2019 21:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=feilDUjQ5x/59LFnxlxvW8WwQKzwk+wbXzAfXtSise0=;
        b=VYJbCCRXBL9vm9AuHqkXrEa9kVoSz+5rrJpTVyktE6DIHKNZNFmUF2RuEvqsoK1K+O
         X/0BlBUAgkg8j8qVtACyb176L/4yDY0JPoafHJWo3i1wNkHuTiZnRVJzl17SumxyXm7Y
         nRArW3adCtHAiN7bgsL8EBsEp4MV2VpvLLBrd8BL3GsIo7JwhpIvNKKRAvutZaFxCJnB
         P52VZy7Uy3c3hIs+mUN20tTlTau3zH8MnOu0SJp2WOUP9/J0y+Z5gj+YDQuS4c58Owy5
         FmxilFWia0Y+F6/0xJ5RiLRZp48O6UqeIH/veMn71cxq1UYoLQqBoExqBaGubAv8STyt
         t1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=feilDUjQ5x/59LFnxlxvW8WwQKzwk+wbXzAfXtSise0=;
        b=Cb9F/m0r9i+HbaKMLvX4k+HlmPOr91+Nv1X3zrHKI56EifwHIBBS6dJgJ4/C4/UGXf
         8iY6JMzV2rZ0pAy8sETnlSIBNii8WS7GAIyQpTLnBvGcFai8pVPNIO/WU7RkOcwOEJpn
         7MiHerFpl6FEBeKuoXr2AilZhNwEQrxe4cBPwcQtxaixVEM4qPEKxKkr6ahRscW7rCxG
         zIgyZJNUtY6r2OzOV0JrrDxzTe3omfVufUnfnTa2pCvCV77N4aZ1MAEYW0QrBS6ArIeL
         DfvVJGHRBZnCof05dE80G9fAoXhowV7rhaD1fv4SQKj+v/BswSOU6yHqlRmsHwY0yRao
         E1qg==
X-Gm-Message-State: APjAAAU2G6CK6B7WonWXIJneVwgaavlBtlfI2n4NaPjeXQ2Rvy4A3wtz
        KaAeozgTzxkrNkmOgTv9LRW9CxB921wCAqJR9UkvntXT
X-Google-Smtp-Source: APXvYqyZGR0NZQ8bv6c3yoRKpCaYYkLhmwJdhA1EWsd+QoiFfP0AuklbkWnmoMCBC/UXHcJJwGfVwZdRYzrqUElTLIU=
X-Received: by 2002:a17:90a:2551:: with SMTP id j75mr3705887pje.122.1574140074250;
 Mon, 18 Nov 2019 21:07:54 -0800 (PST)
MIME-Version: 1.0
From:   Bala S <balas2380@gmail.com>
Date:   Tue, 19 Nov 2019 10:37:44 +0530
Message-ID: <CAJKzgVtzD7ULwCDVRSLMCmGJNaMqvx+jVO619t3xuv2oiEsPMQ@mail.gmail.com>
Subject: Suggested Patch is not working for 22851 Bugzilla issue
To:     mhocko@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mhocko,

https://sourceware.org/bugzilla/show_bug.cgi?id=3D22851
For the above issue, I have found the patch.

Patch link:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1561935.html

Only change i noticed is 'MAP_FIXED_NOREPLACE' is used instead of
'MAP_FIXED_SAFE'.

I ran test case on the following targets with this patch:

1. For X86-64, Still i could see the reported issue( 'libevil.so' just
runs =E2=80=98cat /etc/passwd')

2. For MIPS-64, i am not seeing the malicious file content as
reported. But =E2=80=98ldd=E2=80=99 could not found =E2=80=98libevil.so=E2=
=80=99.

root@qemumips64:~/LIN1019-1806# ldd ./main
        linux-vdso.so.1 (0x000000fff1f20000)
        libevil.so =3D> not found
        libc.so.6 =3D> /lib/libc.so.6 (0x0000005e46f70000)
        /lib/ld.so.1 (0x000000fff7888000)

I am not clear why this patch is not working for X86-64? But it is
working for MIPS-64 with some issue.
Please let me know, if anything is pending on this patch for the reported i=
ssue.

Thanks,
Bala
