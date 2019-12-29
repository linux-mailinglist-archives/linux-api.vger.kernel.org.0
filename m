Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E683F12C311
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 16:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfL2PI4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 10:08:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41535 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfL2PIz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 10:08:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so10525747oie.8
        for <linux-api@vger.kernel.org>; Sun, 29 Dec 2019 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=JpqRu20LZHxdWN1UW9AkuUQvQXkCetz6nWnrVXZaXRg=;
        b=S+uZxX+EaQmPyB6zJ2fqU/hUZuwlpmMS4Hu3op3yUKzfg+ck49mpuWaMrCl8Ro03Sf
         P05YwiT9hWqZYAfCCPEX/l/A8d5Fay2EEpm05+o4kmdiBfoEXLTD88+5f/1LLws9AsN+
         nYHetUMmzMlUs+pTTZ+yL/MCwEHdNtXJ0AjyriI6S2AWH91p4gMxlmiILlQscp4l5bZP
         tkmzsKjJd/j+6FFjOYdh2mz4cu9GyxzT7vp8Scpt+up6IoUN2jTI5FKBH1OyxHyM7U56
         9gMqeHWsAx7qlHry2TcgBE5OUIKF7xYIP7qIHkbtrVOCZgz1eZlnSJt0mat7uv7604if
         SXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=JpqRu20LZHxdWN1UW9AkuUQvQXkCetz6nWnrVXZaXRg=;
        b=RE9v7wvFQYnyrmkGecYtuRc99kfuWXz6Ub51KZkzf8mAzlUBIzQlYlTqDhI6EY81Ot
         J6MfKfZ69l8pY1J1WXuYub1JCzpTY7qSw7ynkpEBd6FJNu4hhUL6eZyL2yY0sNHkiC6Z
         wu26GM2gl7c3mJw6iSYxoOTZ1xdzBuHQF89Ziz3hUm4X3JNBiKnod9AWhT9mubEw3gdF
         zihIQrWrK02M5ziSEjvfRYuknfyeaqqSEetdqUJzDMIxkstXFr9swHFNjFUJjK8WM/NU
         Tr43S0Q9kzESFoWvD/JHjk1qBkpsVmcwbitZ2BVg2RarUSVPEI3UDX+lmdFI26e8naQD
         ZWkg==
X-Gm-Message-State: APjAAAUFDj9nSRtjXP+7cckr89u3Jx1WTw5F5OGcgT8DLRb9cesXkSQr
        8oBpxce4g+zG/MkNPMNlS8OeEg==
X-Google-Smtp-Source: APXvYqxjo/qRxZba1IgLCKplUt2/vIzbNAMP97x3QWuUCy1ztu/OkNu7bZ2vnDIB9uXXfpGv2kA/vQ==
X-Received: by 2002:aca:758a:: with SMTP id q132mr5236846oic.162.1577632134837;
        Sun, 29 Dec 2019 07:08:54 -0800 (PST)
Received: from [26.83.181.6] ([172.58.107.236])
        by smtp.gmail.com with ESMTPSA id t25sm12835238oij.17.2019.12.29.07.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 07:08:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Sun, 29 Dec 2019 23:08:50 +0800
Message-Id: <AA6F6C68-CC2E-45ED-974D-1667769AF679@amacapital.net>
References: <20191229144904.GB7177@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <20191229144904.GB7177@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Dec 29, 2019, at 10:49 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFOn Fri, Dec 27, 2019 at 06:06:56PM -0800, Andy Lutomirski wrote:
>>=20
>> I'm thinking of having a real class device and chardev for each hwrng
>> device.  Authentication is entirely in userspace: whatever user code
>> is involved can look at the sysfs hierarchy and decide to what extent
>> it trusts a given source.  This could be done based on bus topology or
>> based on anything else.
>=20
> Yes, that's what I was thinking.  Another project on my "when I can
> get a round tuit" list is to change how drivers/char/random.c taps
> into the hwrng devices, mixing in a bit from each of these devies in a
> round-robin fashion, instead of just feeding from a single hwrng.
>=20
>> The kernel could also separately expose various noise sources, and the
>> user code can do whatever it wants with them.  But these should be
>> explicitly unconditioned, un-entropy-extracted sources -- user code
>> can run its favorite algorithm to extract something it believes to be
>> useful.  The only conceptually tricky bit is keeping user code like
>> this from interfering with the in-kernel RNG.
>=20
> The other problem is the unconditioned values of the noise sources may
> leak unacceptable amounts of information about system operation.  The
> most obvious example of this would be keyboard and mouse sources,
> where today we mix in not only the timing information, but the actual
> input values (e.g., the keyboard scancodes) into the entropy pool.
> Exposing this to userspace, even if it is via a privileged system
> call, would be... unwise.
>=20
>         =20

Hmm. We could give only the timing.

We could also say that the official interface for this is to use tracepoints=
 and punt everything into userspace.=
