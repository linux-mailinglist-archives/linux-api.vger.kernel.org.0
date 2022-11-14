Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F5627863
	for <lists+linux-api@lfdr.de>; Mon, 14 Nov 2022 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiKNJAf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Nov 2022 04:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiKNJA2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Nov 2022 04:00:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A601CFEC
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 01:00:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so9987930pjd.4
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 01:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHVvZDZbyEogVtk3XYqfqyWzOeOsXZdmYG4Vsfr4Pzs=;
        b=IGlH+a/boVb7i6zolSK0zEvoMEddtxxH2nmc93lCCFV08bOZCNlgJxgFDpF0/JPDHu
         ckYIGRfz/EA6eMc0VzdGQD4o1oB48QASsZlQIPKQ4BQlDOc3hHV4plz+jza1GFZ/VVjc
         nTf+60GJLFAy4UVqpFpMpYwATK9woaMgfDBav2fX9dc2oUUVytTfnDZm2POJF9JsXFEU
         RuMh+Tb5gNg6/ehHkMlHXQhE2ZGSs+MeqRjBBsUWLunO9jpHkixaOind7phxwkQxktl5
         5SwJCZ9A4LQ2zUWuwMDqrLaHDIfzIDda+5BUT9byEbOAV899p/9dGl5MLl6kQ7TOJQR4
         CAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHVvZDZbyEogVtk3XYqfqyWzOeOsXZdmYG4Vsfr4Pzs=;
        b=0uVaCYbVp18KpWaBCN8mZG0SZDptZuRB9GBlgrL/iRoWjtpl1Rf59dFJa0GryTyveM
         7X5jQYXG/kmIyofE+fA9ij1TO3BBikCJDt2z0i/GXaDMTu/eHttemnoLehU//+kB2RNC
         3WsERJ4epWbu3CUcjGSejNC2zesKQTYjZEstPmGINFetyorJOaf+SOq/slzqntx0k3Ra
         wX+yt/DTlZTKgax67O0ntkaoLJ5UM0QM+U7YEXxiZ6GsRC4wAJmCNMnjc20vKQYRXCAt
         gOIk8HgwfMvY+KTkBfPJj0NXwT+nbmp8dFc+E0UdjHkLumf4gKPhn3Y6McAM28Hjd2b/
         U0+Q==
X-Gm-Message-State: ANoB5pmTLFWsKhprzTJ+5fzrHj7XlAoGvKYwnrIXpKySLk1vNtoFSZwQ
        rd4lkbTu7NpwGZMuhmHcJUpTOQ==
X-Google-Smtp-Source: AA0mqf5cZNQj8u+ZxbCaroI0Pmri5Pe5JqwutWZDxOXw61J8pMLqk/LVBKLC6XaybdNpMOnMuMHJrg==
X-Received: by 2002:a17:903:1009:b0:17f:72a4:30a1 with SMTP id a9-20020a170903100900b0017f72a430a1mr12980922plb.124.1668416426378;
        Mon, 14 Nov 2022 01:00:26 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b0056a7486da77sm6371684pfg.13.2022.11.14.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:00:26 -0800 (PST)
Message-ID: <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
Date:   Mon, 14 Nov 2022 17:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
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
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Miklos and anyone interested in this proposal, is there any update on
this? Sorry that I didn't find any..

Thanks & Best regards,
	Abel

On 5/3/22 8:23 PM, Miklos Szeredi wrote:
> This is a simplification of the getvalues(2) prototype and moving it to the
> getxattr(2) interface, as suggested by Dave.
> 
> The patch itself just adds the possibility to retrieve a single line of
> /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> patchset grew out of).
> 
> But this should be able to serve Amir's per-sb iostats, as well as a host of
> other cases where some statistic needs to be retrieved from some object.  Note:
> a filesystem object often represents other kinds of objects (such as processes
> in /proc) so this is not limited to fs attributes.
> 
> This also opens up the interface to setting attributes via setxattr(2).
> 
