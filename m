Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3F2F7C24
	for <lists+linux-api@lfdr.de>; Fri, 15 Jan 2021 14:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbhAONKB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Jan 2021 08:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbhAONJ6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Jan 2021 08:09:58 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD186C061796
        for <linux-api@vger.kernel.org>; Fri, 15 Jan 2021 05:09:42 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so11523296qkm.8
        for <linux-api@vger.kernel.org>; Fri, 15 Jan 2021 05:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7a2Qm296cC6qbzlJc38VnIZ/KuXTiCMBFfueaiUY6s=;
        b=HhG7Vkhd8AavTj0t2yqSdp31Wh7TrUYbiiCcE4W/14z+SxTW/H4+OZ6H7DXFDgLjdS
         KaNai07iXxq5dV+Is32XsN74C81/YK+m8oc2IcIjKQCyj1EiliCnjea0w5AzoT4r7z8x
         Xq4T+oJ3AJXdnxKk43LCCg9wZUR5tN4s2XwDqxVq87qW+ftH35HHFijiPCM+eMKUGCvr
         AUyK010xL1fOpzcvpKmuwVjVhW111tWs3zkP16Sjh2kZ7lg5nGxyK3fOa5aVdS+hYP+r
         0VIxUae0W4fwEsbg5tuwUUS/B5Xr5H54BS2Bs1PJuHx0BDT3BvR3QShzjJioQ2S2LLns
         IJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7a2Qm296cC6qbzlJc38VnIZ/KuXTiCMBFfueaiUY6s=;
        b=HH2lBkQSb9Rd8XWgog8E34Jg37q2a53pTr9X+oSfATf4XyX5fnWRgGSm2NmFhx9+H6
         fXxE+YoCLX+AnMSZ9OTWOfOcHv/iqRgIMeNrJPRX5mn6NQ0Fio5Z/awoCFMpdfDIHIHk
         TDTSkJQ3GXLdv3lPzWAlqBp/ioRioR1gBXnxyOj2N0boq6wIU+luJxyVgVHXUdbp/c/+
         Sdo8glsqJRh1Wo1HX7VyWeU4Lbo31fk9lL4CA1348ZN0XRTr8slbaygK8B3DiLeJG9nZ
         Ja86ammdxM3v5F5IFUlFVpYylNi+b+IERdLJKer3i7h8lPnMxilnYCg9PxF/h2T/F9CF
         gCWA==
X-Gm-Message-State: AOAM532L3/0dtDUA3UHtxZyAMle4HqfH1RFg/TvRcf81kelhlnfOK4kA
        5kNKPH75wCHY6D0GDQ7HZmdPjXTkEyrLJIHGE3jmmA==
X-Google-Smtp-Source: ABdhPJxWr0zaybCu3a2fA0OzXR7u6eWiNfWjgV4mvQwlHIOC1yGcfNCMrk1/WAKWTbuG5iJmmnz6wuPqTkKPXpI0Rgc=
X-Received: by 2002:a37:9a09:: with SMTP id c9mr12379776qke.392.1610716181868;
 Fri, 15 Jan 2021 05:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <5ae22590-752e-7ea2-5341-a49a99e7507d@suse.cz>
In-Reply-To: <5ae22590-752e-7ea2-5341-a49a99e7507d@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 14:09:30 +0100
Message-ID: <CAG_fn=Vp0b3GX78azCiNsqAVs2Pj3bDikSUsf2kBZh7XiX+hzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add sysfs interface to collect reports from
 debugging tools
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 15, 2021 at 2:06 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Should have CCd linux-api@, please do next time
Thanks, will do!
Shall I also CC the v2 ABI patch explicitly?
