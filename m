Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994CF70FB58
	for <lists+linux-api@lfdr.de>; Wed, 24 May 2023 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjEXQGd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 May 2023 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbjEXQGS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 May 2023 12:06:18 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81086E5D
        for <linux-api@vger.kernel.org>; Wed, 24 May 2023 09:05:55 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QRGHr3SDvzMqlKR;
        Wed, 24 May 2023 18:05:44 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QRGHq3DFbzMqH8c;
        Wed, 24 May 2023 18:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1684944344;
        bh=FD09qEaV3/2jau/SWAwtr2q8yhsKAfrQF6LH5pvU4bM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oLWU4Zanc007IbN5Lrih5Gww5A6vVvKKjmVEi2JxB1ZHBEl0OC/ngzrHRXV3dLJv9
         qxhFwu6FR4rj0juLknsMKRUeuFV1gkvXw+3EgHKLObcsXZq/lx81LXDgYENDjT4ydU
         L9LvbbkI9Ch5jafUJwIYWAX+C3v1sNyEFviVNK+Q=
Message-ID: <9b70c2bb-f381-4142-66e8-ade1f1a51407@digikod.net>
Date:   Wed, 24 May 2023 18:05:42 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Shervin Oloumi <enlightened@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, gnoack3000@gmail.com, areber@redhat.com,
        criu@openvz.org, linux-api@vger.kernel.org, jannh@google.com,
        brauner@kernel.org
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 18/05/2023 23:26, Casey Schaufler wrote:
> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>> Adds a new getprocattr hook function to the Landlock LSM, which tracks
>> the landlocked state of the process. This is invoked when user-space
>> reads /proc/[pid]/attr/domain
> 
> Please don't add a Landlock specific entry directly in the attr/
> directory. Add it only to attr/landlock.

The commit message doesn't match the code, which creates attr/landlock.
