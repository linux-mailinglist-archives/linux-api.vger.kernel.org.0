Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C067D5376
	for <lists+linux-api@lfdr.de>; Tue, 24 Oct 2023 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjJXN6T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Oct 2023 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjJXN6K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Oct 2023 09:58:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602F271C
        for <linux-api@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c603e2354fso937218166b.1
        for <linux-api@vger.kernel.org>; Tue, 24 Oct 2023 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698155877; x=1698760677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=dBGQjqFyfkxCERh0ht6T4zHtOMCIAEEElWD0aSCE56alg9Tf21JyvwveX0xPtdPfJM
         2lNl7cJUacZQZfQsx6uluR+8JzJ/pMrkSihbCje0m4cS3jM8oLrrlfpDYCiy6VeP+X72
         nsEYRXs8dvXwPwr3u5i/31goOMOKzmLc8zBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155877; x=1698760677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFq2Fg3zVAnOrmEfLn53FQxN7jmqeIO+YSPDEZIOjqc=;
        b=hnmcTnQYu7OV6VfTgDMgwsEH1PzsQR485ueok2U0Kf7NZiEBOim3BFgyRKDKqZU9nt
         H+Xtgh8WUz0rw6RzMIT1UGlX+VTQw55ZBBzQd+anR9r4/T5zE2Nb1WBdPA6DW9bac84z
         cD7NA5fptGNfB7r0xgkPNyTJ4s1PhytS8EYHizfMQvFqvLyllGmtPv2poU0ZTZfykdGj
         S7CTS6WlgJjW3a3JEjfw/fsI2UeKj4zEd9avv0opwKH0ugDdMg4zzVBIVOV5dobO3bVg
         EBrqdltD8j34W12BISbU1bPe1jLJD/EwgEbPFz35iHeDe6BhEL0RTSIlDYaoNW5d6nqg
         r0Cw==
X-Gm-Message-State: AOJu0Yyu+Iwfg6jPj0A3N5Ehn25thpA35rl0WetEMGZh7+O5geRSZrYM
        9AI8qlWLjRUSZzqJCesJQL8Gc1gJBwZxIVDtke3+DA==
X-Google-Smtp-Source: AGHT+IEV11aVuDatR+GsbiTzkdam4eLmDzs7DndyyWqozB2d9zhCaHb3NdyEF13kC/pQx/zoObUqvAUWAIwVd1XT2cQ=
X-Received: by 2002:a17:907:94cd:b0:9ae:614e:4560 with SMTP id
 dn13-20020a17090794cd00b009ae614e4560mr9998911ejc.29.1698155877064; Tue, 24
 Oct 2023 06:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net> <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
In-Reply-To: <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Oct 2023 15:57:45 +0200
Message-ID: <CAJfpegvTFFzCN9nssL0B6g97qW5xbm6KsrFPRqtSp5B1jaYbLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Ian Kent <raven@themaw.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 13 Oct 2023 at 04:40, Ian Kent <raven@themaw.net> wrote:

> But because we needed to enumerate mounts in the same way as the proc file
>
> system mount tables a flag FSINFO_ATTR_MOUNT_ALL was added that essentially
>
> used the mount namespace mounts list in a similar way to the proc file
>
> system so that a list of mounts for a mount namespace could be retrieved.

Makes sense.

Added a LISTMOUNT_RECURSIVE flag.

Thanks,
Miklos
