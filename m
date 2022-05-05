Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1F51C1C9
	for <lists+linux-api@lfdr.de>; Thu,  5 May 2022 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379257AbiEEOEY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 May 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380311AbiEEODr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 May 2022 10:03:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246256C33
        for <linux-api@vger.kernel.org>; Thu,  5 May 2022 06:59:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so5302377ede.8
        for <linux-api@vger.kernel.org>; Thu, 05 May 2022 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=E8qBemq4oTx4YPbWRWMJzV2qIbcvYOdveNbfeZemz+4dZQ+I0m7fLXmsY75j+/wiX5
         XaE1LThAuxmxZgvbTboIF71ZZ5XDfPUtgSQz8ZVQ2PL1AE4CxYt/PmItFNePGMLFoNgb
         A8tRUVmKiVc6KZIJU/kk/0DlACH0+77UO+Qz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cdP+QQ3RkXNjtwvBi4VN1FsvGgtTlKBfCuL8UUAtAI=;
        b=cpoEtTO1pLBCwh5TQgX4SmNu7Eck5b2EvyTgZpwrndYMX6LEfvQAyig1yaKtltuUsZ
         lAIIEHwJiBDcZVt9lApTIT8wmFPZtaWLXPkfk43OuDXwzrxRnZJfLAPoxO5emEqW6M2t
         quzy20GHn+aHj0znjWQ2iqMeqhtDnHjRA9ot/lMoc42vHZP31hHzCp4u2bX7NvhOZL8U
         Bvg+MkPcw+HDAWt3GczaQu36kG6peX8RjOm2m7kHKEaGA+gZmgZ+EF5BJzHKylpyn4zJ
         skDvgB556JLynMv9TlVTyrquuh/6Vf38UXadcDvWV+DsuZwXKXVzDC7DKovhLDnUm73a
         pw6g==
X-Gm-Message-State: AOAM5322ems4tzA63AsNN8cBLYbZElKP9unxKx9inI+NK+X9uTNJvNl8
        opB/Ot1uSMmLANtkr0KgmMnKdyaIgpDhKtRoHCfCPw==
X-Google-Smtp-Source: ABdhPJzTe+CDKCcscUgOgvXLSyK5NVYs7EmJWj3tio4m59arkqFAPKBq+XxNeijdGRs92739wL1GOOxDMjNo+9z+bh8=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr30384732edx.116.1651759197275; Thu, 05
 May 2022 06:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
In-Reply-To: <20220505123033.sgcyx7kfl4kcfcds@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 May 2022 15:59:45 +0200
Message-ID: <CAJfpegv2asQoevG992+1yruSrmMus57CoQ+=Cssf7O50FhyJyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 5 May 2022 at 14:30, Karel Zak <kzak@redhat.com> wrote:

> Is there a way how to get mountinfo-like entry by mount ID for some
> sub-tree? Something like:
>
>  getfattr -etext -n ":mnt:info:21" /

Yes:

getfattr -etext -n ":mntns:21:info" /

>
> The interface has to be consistent with some notification system (I
> see your question about fsnotify/fanotify at linux-fsdevel) and mount
> ID seems better than paths due to over-mounts, etc.

Right.

If the mount notification doesn't fit into fsnotify well, the original
patch from David could be used.  I think that part was
uncontroversial.

Thanks,
Miklos
