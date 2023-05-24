Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0970FB88
	for <lists+linux-api@lfdr.de>; Wed, 24 May 2023 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEXQRl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 May 2023 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjEXQR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 May 2023 12:17:29 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 09:17:25 PDT
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24AEC1
        for <linux-api@vger.kernel.org>; Wed, 24 May 2023 09:17:25 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QRGNf0gWnzMqlJy;
        Wed, 24 May 2023 18:09:54 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QRGNc5mTyzMq3kK;
        Wed, 24 May 2023 18:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1684944593;
        bh=TLa2gsaL1kVkSutKGt+QaEc5djn5VpfoduhwQDTEOtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yygapqd20M0DhyHBfl/CSUWJsJa//AqcIZkIvrn6W8SgC5uQat1O1VhgNI6n+/mtP
         NylpGI+EBRTilZEbQXgm2pOR+Mo0sgUpQA93QCveZPpLfmzla/+6ZrTnnkXIyTzgFy
         y1hj7KWrESsXWBUYgY2Z5qejZ+wb160afKXBtKRM=
Message-ID: <30aef0b6-0d2c-a0de-0152-a358805f95af@digikod.net>
Date:   Wed, 24 May 2023 18:09:52 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 0/1] process attribute support for Landlock
Content-Language: en-US
To:     Shervin Oloumi <enlightened@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Adrian Reber <areber@redhat.com>, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230302185257.850681-1-enlightened@chromium.org>
 <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
 <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
 <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <CAMb9sThs2QXid0LZ3gwtfJoJUM3mpK0=nobOGpicde7jnuAJ5Q@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAMb9sThs2QXid0LZ3gwtfJoJUM3mpK0=nobOGpicde7jnuAJ5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 18/05/2023 22:44, Shervin Oloumi wrote:
> Sorry for the delay on this. I think there is a fundamental issue here
> that needs to be resolved first, and that is the limitation of the
> kernel that only one LSM's hook function can be called through the
> procfs attribute interface. This is a blocker for us (and I imagine
> for others), since implementing any LandLock attribute API would block
> the existing SELinux hook function, which is used to surface domain
> information. `ps` also uses it to display domain information when you
> pass `-Z`. Please note, this is independent of which path and filename
> we use for LandLock. Even when the "domain" file is placed under a
> different directory, for example `/proc/[pid]/attr/landlock/domain`
> the kernel only calls the Landlock hook function for any interaction
> with any files under attr (the kernel always calls only the hook
> function for the first loaded LSM in the kernel config). So if anyone
> in this thread has any information on whether there is work on
> progress for addressing this issue, that would be helpful.

This seems to be an LSM stacking issue. Do the LSM syscalls also have 
this issue? This should be part of tests.
