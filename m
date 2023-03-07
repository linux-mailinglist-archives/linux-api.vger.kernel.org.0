Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0C6ADE13
	for <lists+linux-api@lfdr.de>; Tue,  7 Mar 2023 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCGL4L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Mar 2023 06:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCGL4H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Mar 2023 06:56:07 -0500
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F25BAD
        for <linux-api@vger.kernel.org>; Tue,  7 Mar 2023 03:56:03 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWDRk09K1zMqkg3;
        Tue,  7 Mar 2023 12:56:02 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWDRj1fcWzMshJ6;
        Tue,  7 Mar 2023 12:56:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678190161;
        bh=Qww26H1yUUwtSMxC6i+kAuI0LFixrmQllXQbj8G5NEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J4NTZPs/tzayd9rMlEnVil8Y+FzVgqGymXF1uwABzk+7e3FHDPju2DCTKojRkXR18
         QE+qxkjSqXRFh2WOfKdjRbqvkmavZ2cT4NxhvwSpnO/OolRBHpDDMWLlEYfgYvA+ym
         7D33QaIIhtxfSOqoPdsaL/1a9N9Wfbvvv3tHaQ2o=
Message-ID: <83b6310f-6101-2cdf-ec41-b850fe66b1c2@digikod.net>
Date:   Tue, 7 Mar 2023 12:56:00 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-5-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230222200838.8149-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Let's say an LSM need to pass a file descriptor instead of a text value. 
Would that be possible or would it need to use another interface?


On 22/02/2023 21:08, Casey Schaufler wrote:
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifys the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>          __u64   id;
>          __u64   flags;
>          __u64   len;
>          __u64   ctx_len;
>          __u8    ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
