Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40969510276
	for <lists+linux-api@lfdr.de>; Tue, 26 Apr 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352750AbiDZQEP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Apr 2022 12:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352826AbiDZQEM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Apr 2022 12:04:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6E38BFE
        for <linux-api@vger.kernel.org>; Tue, 26 Apr 2022 09:01:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h8so283471iov.12
        for <linux-api@vger.kernel.org>; Tue, 26 Apr 2022 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyCNcdxP+OP+ZEEDkKpS4dIut/dFXRkxuAQItAbC2hk=;
        b=kkI2HO5/ZEBb6dwCosEFba8Hqs93phXW7y7LQIwDiDweskbxzWfkhJOxUXgbksafGv
         Cj9I3+VUsMtqzbQ+FRheYG7Jnp0nCQoqCtylg9A9uVvjFZFE+gYUol4vZnJS8L/D7fcH
         IXLA9h7oaFPNuHm4FrQjgkuQGxMTT+zn4y0Dc3ZUaMQ6grfstTlV1uURhTu7yZhAB2CR
         S15Az/6PGwq5RzEtyE76iZSrukPtIepHVy15uTIKCKRfoQGMqwl6nQ2Wcrtywgqq4l9K
         yrTT7rEccOM0wyFm2LgURZQ9atXRmAewK37yNCUoS/4n8PFFGhjVqFY7J9psP2v3Z2G9
         KjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyCNcdxP+OP+ZEEDkKpS4dIut/dFXRkxuAQItAbC2hk=;
        b=s1NRFuN+8pbFcf+ZbQGN+hJnBKzIR0bAOqKYBQalyjvGBHwfFca0YQ3+ffNvXWNtxZ
         q1D5irdLqnsQwP+ktAa+AIbyL7hgFnP0EIeMqfcZYa3VBQpk3W/zHHKD8KKS4AcMs0PC
         AOd1VZ40HzWaf1UhBzMkvawrLVck0/7dArD1wcRDV3SEsM2+ovPTUNvEWOLZ9K5RHlYu
         tHp2jFcIAiAYtgCRV2OuluGXtdlRtjTGZRKNoG/2bGXXXlYyj+KVIUGfrFe1KcUAQj01
         r6yNfilqmtHOsgco0DTjEg0q9ne74j62EqYdRFNpYdssuWoo6gJdHsr+x/tdJmtoGAx6
         8ytg==
X-Gm-Message-State: AOAM533xnlWBWZoSXUH2pKsaZpNebZSKA+eZ8y8KtU25EPUyEcRoCIHM
        CeL+R857XYTPIMpfSwTb4WfAORknRC/hZr6DIwnE7A==
X-Google-Smtp-Source: ABdhPJy2p2YsSAWaLRUyeCx9GIenmVZnYXSr1zBWwbH2S+IZQF4NN6DuvWqwwrbZ5neEqlH8OPqJygq6V4YSc9feqz0=
X-Received: by 2002:a05:6638:1695:b0:32a:a178:98bc with SMTP id
 f21-20020a056638169500b0032aa17898bcmr10205311jat.167.1650988862310; Tue, 26
 Apr 2022 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-3-axelrasmussen@google.com> <20220425203249.GA5814@altlinux.org>
In-Reply-To: <20220425203249.GA5814@altlinux.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 26 Apr 2022 09:00:26 -0700
Message-ID: <CAJHvVchLSpbKXn6u451pjaRpW=SwbOFSdpQpaC47WBFa0660xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

You're right, [1] says _IO is appropriate for ioctls which only take
an integer argument. I'll send a v3 with this fix, although I might
wait a bit for any other review comments before doing so. Thanks for
taking a look!

https://www.kernel.org/doc/html/latest/driver-api/ioctl.html

On Mon, Apr 25, 2022 at 1:32 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Fri, Apr 22, 2022 at 02:29:41PM -0700, Axel Rasmussen wrote:
> [...]
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -12,6 +12,10 @@
> >
> >  #include <linux/types.h>
> >
> > +/* ioctls for /dev/userfaultfd */
> > +#define USERFAULTFD_IOC 0xAA
> > +#define USERFAULTFD_IOC_NEW _IOWR(USERFAULTFD_IOC, 0x00, int)
>
> Why this new ioctl is defined using _IOWR()?  Since it neither reads from
> user memory nor writes into user memory, it should rather be defined using
> _IO(), shouldn't it?
>
>
> --
> ldv
