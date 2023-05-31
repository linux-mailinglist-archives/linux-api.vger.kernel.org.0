Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4517E7180F7
	for <lists+linux-api@lfdr.de>; Wed, 31 May 2023 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjEaNGi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 May 2023 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjEaNGc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 May 2023 09:06:32 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E986183
        for <linux-api@vger.kernel.org>; Wed, 31 May 2023 06:06:11 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QWTsY3ZQvzMrfgS;
        Wed, 31 May 2023 15:01:05 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QWTsX0JRMzMpsR2;
        Wed, 31 May 2023 15:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685538065;
        bh=CBQFEd038q47Nd01fBSEoyypq1IMm/2mHK3jcG5o/DM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ShQLnkRcaN5AyxMcyDjitgfJ38ZECABg2GXWbipOpy9w6dssjoM6HcGJxsVM2GIsP
         nQbPwSAmBNTBkOxvuAG++4MCUtw0pui1FCXcYvkDsv6pGmgnDcD5RJy3gNGxTRRgK2
         gQhwHrMVNVPCLqPxQ6jjmT1Z5nAI88gXNbjvo1NU=
Message-ID: <9ee2bd8b-5150-1dc6-d845-733ca9b68d26@digikod.net>
Date:   Wed, 31 May 2023 15:01:03 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
 <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 30/05/2023 20:02, Jeff Xu wrote:
>>>>
>>>> As I believe we are in the latter stages of review for the syscall
>>>> API, perhaps you could take a look and ensure that the current
>>>> proposed API works for what you are envisioning with Landlock?
>>>>
>>> Which review/patch to look for the proposed API ?
>>
>> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/
>>
>>
> How easy is it to add a customized LSM with new APIs?
> I'm asking because there are some hard-coded constant/macro, i.e.

I guess this question is related to the Chromium OS LSM right? I think 
this would be a good opportunity to think about mainlining this LSM to 
avoid the hassle of dealing with LSM IDs.

> 
> +#define LSM_ID_LANDLOCK 111
> (Do IDs need to be sequential ?)
> 
> + define LSM_CONFIG_COUNT
> 
> Today, only security/Kconfig change is needed to add a new LSM, I think ?
