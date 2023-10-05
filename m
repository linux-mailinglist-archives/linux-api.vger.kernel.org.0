Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BC7BA4C5
	for <lists+linux-api@lfdr.de>; Thu,  5 Oct 2023 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjJEQKx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Oct 2023 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjJEQJr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Oct 2023 12:09:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567E7E214
        for <linux-api@vger.kernel.org>; Thu,  5 Oct 2023 08:52:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1897178a12.2
        for <linux-api@vger.kernel.org>; Thu, 05 Oct 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696521147; x=1697125947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=kaAKFbtGGjgq+daw7tAPVKBzxgbEZS9H7gZCMFN6Loa+RDfMDJJPx7OVmEaJtr5nO7
         whXAfc+4mSiqQGPVk8UZrzWIs7N9mg0yc5MiqbSkhy+B0awBpFHbdak6CYFQcvlZTqv6
         9DxxkWBBlTnGtHFJcuQ0qxZx2w3BZ416UgQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521147; x=1697125947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=hICO+TxPQfv9mw/RRyXRMDi1I/I02RF9a+kQq0ZhWti4BSGO9DkcIv4i1jIEomE8xc
         vSvTEhr4+UYrwc0cX5y5rDw6KaUzqiIugbmYgXPcfF78fe4XKzMvOOWz0D/sc4MFVLjN
         5XWtfNuTx89x/ccefS7SKlFXQ5DnxpdKNBe4qgNLJ5s5A9FrWUvEpxKpACTEtUzdN29M
         g55rLiryX7VN+3t572/QaFTGbDcV1GPhvAeF5R/GHdcjyTMnfrGk/MVM4YFVJ/zYX2PV
         fY21EPiOziN7Ztk1B17dSuKIpqmvOTW7po2lc4iZm/lpOgEwWG5Jb1UCb3rmt3Eu/mh5
         4DFQ==
X-Gm-Message-State: AOJu0YxsSsrCFmQuqZxN65R+TEbZ5bqs/38nF9EBUxETMDI6iFRKjlib
        6FhhVY0JJz9RNpGiSaUBTCYwwM4bA0rovIh2ZToGbA==
X-Google-Smtp-Source: AGHT+IEjk91u8XSDRTtHtK1m9U1BbYI9ul1sY8PRZffqsVYEFnsO8jHMq77QF4AYuvBhByku9bOaBTvxJTmlGFVmmZk=
X-Received: by 2002:a17:907:724b:b0:9a1:fcd7:b825 with SMTP id
 ds11-20020a170907724b00b009a1fcd7b825mr5098742ejc.71.1696521146721; Thu, 05
 Oct 2023 08:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-2-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-2-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 Oct 2023 17:52:15 +0200
Message-ID: <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] add unique mount ID
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 28 Sept 2023 at 15:03, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> If a mount is released then its mnt_id can immediately be reused.  This is
> bad news for user interfaces that want to uniquely identify a mount.
>
> Implementing a unique mount ID is trivial (use a 64bit counter).
> Unfortunately userspace assumes 32bit size and would overflow after the
> counter reaches 2^32.
>
> Introduce a new 64bit ID alongside the old one.  Initialize the counter to
> 2^32, this guarantees that the old and new IDs are never mixed up.

It occurred to me that it might make sense to make this counter
per-namespace.  That would allow more separation between namespaces,
like preventing the observation of mount creations in other
namespaces.

Does a global number make any sense?

Thanks,
Miklos
