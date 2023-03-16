Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223736BC607
	for <lists+linux-api@lfdr.de>; Thu, 16 Mar 2023 07:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPGTH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Mar 2023 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCPGTG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Mar 2023 02:19:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542524495;
        Wed, 15 Mar 2023 23:19:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so2937603wms.0;
        Wed, 15 Mar 2023 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678947542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyHrcqWFBSWtab8SyKab5TDPo3snngThO+lUfc1u9tg=;
        b=Y0udMzUjNYRY3D9xa1szjfCJ/kBb1OvwCugmuXDbDInMLfjgIajtcRU5hu/SuSpl2a
         2uua8BGlj78j7+FDOoIwGEMS0n244gWrDqZZX586THKdjxc4mT61zusv4KYt0ExCbnt0
         /IiBCHp3qUdKJNBWGGm20hObjgC1N0k7MY9A2jV1Xz0ww1+IjvfSDaI1ThDAOcUTA18X
         rQ13ZbRRtkppzOjS++pE/e9tSZqGsOC4uZlOHzxB4uuhdQI6QNnyAz+OxVfIFkyCrQRu
         X6kV6JFzNAiBYC52a3rETgqUF4Am0IRXQgRHI8n2kCsrrhNrfc6I6420DaaD+X8BLq8J
         KINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678947542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyHrcqWFBSWtab8SyKab5TDPo3snngThO+lUfc1u9tg=;
        b=h9VYsySPMv1oTCWJHqjvP4LOCKYnS1poHkJuIXEVoLtDWHn4Mf3arhJZCv/JRLu0LP
         vn1ZFYt7KZfjE9JKPYV7j2TY0yDbEZS/YyoAaaW+VLau0HVCYzkn9UXo0D8rMDme0GWr
         QedULSPRoGBLQGzqLJ+UeCr00Z7Zax9yIS4xDeQSWCDUW0x60D88J3DgExFxNVaYW9cT
         AzGqdNKIYsfVYj9NMj7OgKkH01+8uOM2xAvBWn3AKXG+hO+vz1AZ3lX0s9a2KsuaOkJ7
         A8ifKN7EtP8PFC++4va6oRQHUOl3DmlTsgvElbG0fPSyeXZ7x9NhYLh0Ga58x2UJ8TIe
         Lb+A==
X-Gm-Message-State: AO0yUKWyOAeokCkKQ/G2PoUqAnPihbEwiaSOuvlK84tKPZgp7Jhhe8pJ
        /m7aBzpWyIGH0AUkU91H0Ow=
X-Google-Smtp-Source: AK7set98a3L+TiNLZM4xwZq0+axqv9h8VsLrqd+dK9AYkrlIHU//dD3OT1dCizqdClO8BQOLwmShnQ==
X-Received: by 2002:a05:600c:4fd6:b0:3ed:3e72:3566 with SMTP id o22-20020a05600c4fd600b003ed3e723566mr2535883wmq.39.1678947542552;
        Wed, 15 Mar 2023 23:19:02 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:7c09:9c3b:256e:8ba1])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003ed201ddef2sm4019793wmb.2.2023.03.15.23.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 23:19:02 -0700 (PDT)
Date:   Thu, 16 Mar 2023 07:19:00 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, Adrian Reber <areber@redhat.com>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Message-ID: <20230316.17835bf118d5@gnoack.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
 <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
 <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
 <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!

On Wed, Mar 15, 2023 at 10:56:03AM +0100, Mickaël Salaün wrote:
> On 08/03/2023 23:25, Shervin Oloumi wrote:
> > Thanks all for the feedback. This is in reply to Mickaël, but should
> > answer Günther's questions as well.
> > 
> > > It would help to know exactly what are your needs short term, and long
> > > term. As Günther is wondering, what about nested sandboxing?
> > 
> > Our plan is to use the "landlocked" process attribute defined in the
> > patch to determine the sandbox state of the system processes and send
> > information to our metrics server regarding Landlock coverage. For
> > example, the percentage of processes on the system that are sandboxed
> > using Landlock.
> > 
> > Given that we use Landlock in a very specific and controlled way, we
> > are not concerned about the inheritance behavior and nested policies,
> > at least for the use case of metrics. When daemons are launched in
> > ChromiumOS, they have a pre-defined sandboxing configuration that
> > dictates whether Landlock should be applied or not. So this attribute
> > would help us verify that the processes running on devices in the wild
> > indeed have the general sandboxing state that we expect and the
> > reality matches our expectation.
> > 
> > Long-term, it would be useful to learn more information about domains
> > and policies through the process attribute interface, but we do not
> > currently have a need for that, apart from maybe doing troubleshooting
> > when defining Landlock rules for system daemons.
> 
> OK, it makes sense.

Fair enough.  I missed the fact that this was about the OS rather than
the browser.

Still, out of curiosity: Hypothetically, if you were to expose the
number of stacked Landlock policies instead of the boolean in that
place -- would there be any drawbacks to that which I'm overlooking?

It seems to me, superficially, that the implementation should be
similarly simple, it would be useful in more cases where Landlock
users do not have control over the full OS, and I can't currently see
any cases where having a number instead of a boolean would complicate
the usage from userspace?  Am I missing something?

(But in any case, the boolean is also fine I think.)


> > > Here are the guiding principles I think would make sense:
> > > 1. A sandboxed thread shall not be able to directly know if it is
> > > sandbox nor get any specific information from it's restrictions. The
> > > reason for this principle is to avoid applications to simply jump to
> > > conclusions (and change behavior) if they see that they are sandboxed
> > > with Landlock, instead of trying to access resources and falling back
> > > accordingly. A thread should only be able to inspect its
> > > own/children/nested domains.

(Small remark:

Doing anything differently depending on whether and how you are
landlocked is definitely an antipattern which we should not encourage.
But I'm not sure whether we can hide the fact very easily.

It's already possible for a thread to detect whether it is landlocked,
by using this hack: Create a new thread and then in that thread count
how many additional sandboxes you can stack on top.

If you have knowledge about what Landlock configuration you are
looking for, it will be even easier to detect.

I hope noone takes the above example as inspiration.)

–Günther
