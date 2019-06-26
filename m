Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30EC56CD5
	for <lists+linux-api@lfdr.de>; Wed, 26 Jun 2019 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfFZOug (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Jun 2019 10:50:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfFZOug (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Jun 2019 10:50:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so3780515edo.5
        for <linux-api@vger.kernel.org>; Wed, 26 Jun 2019 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xn5/sjr2SkMR21Q+6SAo5VDqXrDegQPvyCLgGPTTURs=;
        b=CoKaEc3wxeHdnMcIofwNS4wPiIsB4YJ0MdREl3n8yGAalh9nxwnCt6s4C7YfqB8J7E
         XZ9CeglN7DhsaHQPGmJ83Xl5B0+DGakBv2quoUi0orpESnYwIZqHJZM9JPLeH4wUZJuZ
         FJg5EF2YLZN5kH2gFq0nfo1K9QphlQ+THUqGo+zpGmjyVGQo59izd65NQ8XrSHqXsJkV
         r+kff83JiIWKJr7BCUU9RQqkV3uJayYQQaUfcPpzsf6Svs9Nf5b9ApGUsLLNm6A7nuXq
         SEJyHZREjdICZ1ASaILln/JIbacf7oWT3YEAa3Gen4dxnBfWB6NHRmCJOP/+w/8WQDYR
         rETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xn5/sjr2SkMR21Q+6SAo5VDqXrDegQPvyCLgGPTTURs=;
        b=HxPU1NoWs2Ta3zRtBwCfmjNTXDrywk08QJSejW5bzeBKku+qyR3wVYa6X7q9rfHrMy
         EFhXTWkie2oJrl6PE8GTV9cgrfwpl/BtgvzNYV28y/9bB/7fDy7E/2DqoTZ0rlqDd0Vo
         Ff1mDVkCdUKXeHSBRPuH/+1nBE8Q0vkQqP2YgEuWfA+aknThkaBlQ1xL8wEgz5Dg7S3G
         z5878oNMNUWt3tP5cCZWqAqQh3FQAYGyF8FAtei2DvXXJFuRonouGFpQAZUeAYbwrkSu
         NFf5EqS+v+Xyf3TUkYk5JnnRSqMz1UbUaxyrTEbyumsKlSYuBc8rQRinKVYQVJK4zU3s
         PAmA==
X-Gm-Message-State: APjAAAWDZPmN1epXbLgm/SisI4ZsQfXDmuIugfBkozUrzWhT48ESr3yE
        P3b0e1fdpM/4Zz8BbPGLc9CnBA==
X-Google-Smtp-Source: APXvYqxihuTlAVHp7Dtm+OQSgaT0vicToPsHIUlp7ShmYxpuuMQHg3Wi0UPDnVnoRgF96oLtm3CiGQ==
X-Received: by 2002:a17:906:7f16:: with SMTP id d22mr4466398ejr.17.1561560634310;
        Wed, 26 Jun 2019 07:50:34 -0700 (PDT)
Received: from brauner.io (cable-89-16-153-196.cust.telecolumbus.net. [89.16.153.196])
        by smtp.gmail.com with ESMTPSA id a6sm5477457eds.19.2019.06.26.07.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:50:33 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:32 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626145031.nvpekusplnt5kqw5@brauner.io>
References: <20190626131902.6xat2ab65arc62td@brauner.io>
 <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <20190626100525.irdehd24jowz5f75@brauner.io>
 <9360.1561559497@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9360.1561559497@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 26, 2019 at 03:31:37PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
> 
> > And I also very much recommend to remove any potential cross-dependency
> > between the fsinfo() and the notification patchset.
> 
> The problem with that is that to make the notification patchset useful for
> mount notifications, you need some information that you would obtain through
> fsinfo().

But would it really be that bad if you'd just land fsinfo() and then
focus on the notification stuff. This very much rather looks like a
timing issue than a conceptual one, i.e. you could very much just push
fsinfo() and leave the notification stuff alone until that is done.

Once fsinfo() has landed you can then go on to put additional bits you
need from or for fsinfo() for the notification patchset in there. Seems
you have at least sketched both APIs sufficiently that you know what you
need to look out for to not cause any regressions later on when you need
to expand them.

Christian
