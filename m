Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986171F419
	for <lists+linux-api@lfdr.de>; Thu,  1 Jun 2023 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjFAUpe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jun 2023 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFAUpd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jun 2023 16:45:33 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE8197
        for <linux-api@vger.kernel.org>; Thu,  1 Jun 2023 13:45:31 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5584f8ec30cso991355eaf.0
        for <linux-api@vger.kernel.org>; Thu, 01 Jun 2023 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685652331; x=1688244331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPCdIXbRJUF9dlLlPYVzvCRH+4MkziI8y7fdBivS2BY=;
        b=IemqlRgg/O1aG5ZQhI4YU3GhHUY3n8fhGXXoWDijMi0tJzuQSxMQkdXdJl0l/9iUCi
         CJaYPPrJhQLyaRqLk25laGXb4roBL6MS3sMB3jOyhbFIVnOei/NOJkspZrJUdAItQRqV
         2dhY7M5vXMxedru3yetGj5sDbK+480mqnaKH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652331; x=1688244331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPCdIXbRJUF9dlLlPYVzvCRH+4MkziI8y7fdBivS2BY=;
        b=PP/yFkoSl5nH98xxCppnxMsCLjuqcbwVOp1vCm0jwocvwkXXBQUx0yRv0SNKhUc6Hu
         BTcYkRDW73tFIKPc8l/TT77CAAAG9p/SDlFI2iJcFY80kopeazdj618RhUbQtlsvKK1w
         j4Ld1ildLLLtE5hnGkh9fvWx3QRpF+tAXsrgQaVV3cVMZKrSS+BE90e/C+XU/YDx/H05
         4rn0vi9v4S/7vTdXFyrG31hoTRXVbyRB3/TXhOdSmWPXhXLeBa6DMgEE29rlBffnGUfY
         86CVcfUlnv34ipXoDQGNbObEMdJUud4HycWJdcmSQFzy8qIT39JM2SPMNAeB+yTaGNWG
         3fyw==
X-Gm-Message-State: AC+VfDxO+gwIXWCMIKdbyKXo2dl/aH9+ESj2Yii2eFsVtg7UFUVdr/sq
        LIROwfqPubwMxWO/R/xysn4ENhAHjLj4LPkNfTIrjA==
X-Google-Smtp-Source: ACHHUZ4stTwZl7eAxtGAZm+tfdD1Uw6n2B6zvpRnc64vSrBwOIPrR7vZlHx1b21uj8GGLmMLeleFlkj31xDV3T404oM=
X-Received: by 2002:a4a:5814:0:b0:542:5d35:12a0 with SMTP id
 f20-20020a4a5814000000b005425d3512a0mr6537652oob.3.1685652331169; Thu, 01 Jun
 2023 13:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com> <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
 <9ee2bd8b-5150-1dc6-d845-733ca9b68d26@digikod.net>
In-Reply-To: <9ee2bd8b-5150-1dc6-d845-733ca9b68d26@digikod.net>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 1 Jun 2023 13:45:19 -0700
Message-ID: <CABi2SkWQz3gvaQVWL30CBM-SDLHrWaGOwQS0rfKi==D9TP8L0Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 31, 2023 at 6:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
>
> On 30/05/2023 20:02, Jeff Xu wrote:
> >>>>
> >>>> As I believe we are in the latter stages of review for the syscall
> >>>> API, perhaps you could take a look and ensure that the current
> >>>> proposed API works for what you are envisioning with Landlock?
> >>>>
> >>> Which review/patch to look for the proposed API ?
> >>
> >> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-c=
a.com/T/
> >>
> >>
> > How easy is it to add a customized LSM with new APIs?
> > I'm asking because there are some hard-coded constant/macro, i.e.
>
> I guess this question is related to the Chromium OS LSM right? I think
> this would be a good opportunity to think about mainlining this LSM to
> avoid the hassle of dealing with LSM IDs.
>
Yes :-)
I agree it is good to think about upstream, there are things chromeOS
did that can be beneficial to the main. At the same time, part of it
might never be accepted by upstream because it is chromeOS specific,
so those need to be cleaned up.
