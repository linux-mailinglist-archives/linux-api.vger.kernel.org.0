Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392B40CAFF
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhIOQs7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 12:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhIOQs6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Sep 2021 12:48:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB5256121F
        for <linux-api@vger.kernel.org>; Wed, 15 Sep 2021 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631724459;
        bh=RXpsF/VO6GEdjb1aQhtYiJKHMct/U0k37GgDFDGgrR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j05dwuutr3ixumWPZWdZIcn+eEOt/vnSb1TnGP9o2pp+YwKIGCoNzYsjFCOUVo4pz
         WjPRbZJqT4GU1lVr/pFLN4xZnFgWQxLEbPPm6waSRAsmR7qGtgkvSdod5R14MlWOjd
         PMnpP7w1LZK4hxdH7iLxck8zaw3Hw9lZ5SZBQqOSLbNuPtuRvBWgPtgeBu101aaefw
         qr1jO7Jlu0/UrCsWuOSXL8YoCi58n24Pb/MD5PEz4MFJctJrqxlXfPL+vKQiQPWz8E
         KKagKKIwaKxlQOh6TIxx73aYyPRl5gleaZZw6jpUPwPFl184cl6+hJZ0w5ueCozUll
         GyqVDHQy2Dg3g==
Received: by mail-ed1-f46.google.com with SMTP id t6so5919821edi.9
        for <linux-api@vger.kernel.org>; Wed, 15 Sep 2021 09:47:39 -0700 (PDT)
X-Gm-Message-State: AOAM531n21fLc3fGB4NMLIMSCznjMviKcw9kX3Y9iSYM0yGrgN/CL/NY
        X0/DrHu9HdVuzURcH5FUH86tOLAXttj/a9ZYlj8zOg==
X-Google-Smtp-Source: ABdhPJynY4FSVmglrMDA36UZlrr7peMUTfEqx8YeTiK3u74IyWamFT9pPKsO1KiexgAnay+21MZnBhxbl1CrQQs4Aow=
X-Received: by 2002:a17:906:1557:: with SMTP id c23mr926887ejd.371.1631724458312;
 Wed, 15 Sep 2021 09:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
In-Reply-To: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Sep 2021 09:47:25 -0700
X-Gmail-Original-Message-ID: <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
Message-ID: <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
Subject: Re: [RFC] Expose request_module via syscall
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 8:50 AM Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wro=
te:
>
> Hi,
>
> I would like to propose a new syscall that exposes the functionality of
> request_module() to userspace.
>
> Propsed signature: request_module(char *module_name, char **args, int fla=
gs);
> Where args and flags have to be NULL and 0 for the time being.
>
> Rationale:
>
> We are using nested, privileged containers which are loading kernel modul=
es.
> Currently we have to always pass around the contents of /lib/modules from=
 the
> root namespace which contains the modules.
> (Also the containers need to have userspace components for moduleloading
> installed)
>
> The syscall would remove the need for this bookkeeping work.

I feel like I'm missing something, and I don't understand the purpose
of this syscall.  Wouldn't the right solution be for the container to
have a stub module loader (maybe doable with a special /sbin/modprobe
or maybe a kernel patch would be needed, depending on the exact use
case) and have the stub call out to the container manager to request
the module?  The container manager would check its security policy and
load the module or not load it as appropriate.

--Andy
