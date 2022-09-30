Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F25F1672
	for <lists+linux-api@lfdr.de>; Sat,  1 Oct 2022 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiI3XDF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Sep 2022 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiI3XDE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Sep 2022 19:03:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3591D848D
        for <linux-api@vger.kernel.org>; Fri, 30 Sep 2022 16:03:02 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 138so4387771iou.9
        for <linux-api@vger.kernel.org>; Fri, 30 Sep 2022 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SqBsvh6C88KVHki7t4Nj5RWCZOuW9N4jEM2i1kXUX1A=;
        b=QV19rN7u49LBgxsERfExNXC4Qifjr+PujO83hWUsqQwWJAXOvZDMqMjRVEDwq/nUYr
         8y2bG+TTsCRkpKYIxMWp8TqRP9q0NhNbhHKapcl7ZvaDlrJTayOSthJN8uY5l9d557x9
         i/hEw2f9ra0wkORLPbcYwdezMlEVBHVdwUCkjEiJh7tiOGHh48T0sJ9EquqQ1m5DhnQ8
         1ycYF/JTKxFOBImu3XQsT+D0d2yQO0F6wmMGdzGRtRwL5UBCP7gM0lmrYUwAPIWwx3t0
         Yr8+kmTHepP1iIeY3YZxS+B1BGhJde4gU45irp5VKxeWy7uNtfVblAI+gIl/XxNQRTov
         W/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SqBsvh6C88KVHki7t4Nj5RWCZOuW9N4jEM2i1kXUX1A=;
        b=i1CLfdU2bfJu+wjFshrDArHRhuzmmnXIwFydoHpqlBUQdI47Xq1CtMNvAhZogA/a+6
         6TJBikhcOqAPbs/XJfXCTdmbeKSwBaHECBaD9QyAZW0pf5Gz2zFkMLfIJbt9Av9stZji
         LbP9ircDF5BYVyEwg3NMkF9y+1izfw6Ge6OJAOvZvN7JtPdyQJ2SElNfSdlIDLznrSEc
         rDv9obapiDKABVQRd+i39OV/7mAFtr1DO/HvmlK/dme+nyt/gbawOmHrtiXbPsqkTqm1
         GXyhB0y/6VV5nrbyXMS7noiRnJJ+36Iu1dvn8CR96svLf3vB/eP++prb0WUv5xt81sPp
         ZNwA==
X-Gm-Message-State: ACrzQf2RHbQamFHAKsEmu0WHy64+8x/mfe9HdUYMTceCrtMxPpZJf+9q
        Ubf/WhEqNqTA9CZS2A2eczhUM01GlCM3yLWx5TYsvg==
X-Google-Smtp-Source: AMsMyM6/1Zo86oY4qRLob+fDqU88N1JO4RXTZoZZODrBjD9wJqjFTLtKUMBKFRj4TR8qKrKyDwQEelk6KAJ1qvm8qrk=
X-Received: by 2002:a6b:5d02:0:b0:6a3:46d5:a08d with SMTP id
 r2-20020a6b5d02000000b006a346d5a08dmr4696832iob.2.1664578981372; Fri, 30 Sep
 2022 16:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com> <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
 <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
In-Reply-To: <CAG48ez3-dgcrLxKNAs4_K++FXn-9qL=6kjVY=2Cn-AxoML33Vg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 1 Oct 2022 01:02:25 +0200
Message-ID: <CAG48ez3DNXjH+h+VFAiBwg+ebwxM6a_VsF=QKzXCDEE7QzTNvA@mail.gmail.com>
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
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

On Sat, Oct 1, 2022 at 1:00 AM Jann Horn <jannh@google.com> wrote:
> So I think this change is actually a no-op - the only thing it does is
> to return 0 if write==1, !_PAGE_RW, and _PAGE_DIRTY. But the check
> below will always return 0 if !_PAGE_RW, unless I'm misreading it?

Er, to be precise, it will always return 0 if write==1 and !_PAGE_RW.
