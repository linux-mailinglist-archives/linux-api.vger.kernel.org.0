Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A30E8B8B
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfJ2PNs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 11:13:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43895 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbfJ2PNr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 11:13:47 -0400
Received: by mail-io1-f65.google.com with SMTP id c11so15147775iom.10
        for <linux-api@vger.kernel.org>; Tue, 29 Oct 2019 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11HABgG4cgofeXKrR7yB4qVxOwjvZW+qOCi2NPimHbk=;
        b=eSOY5l0EBsO+rrEeDHKewSn+1rtEbKi8WrMI2sePTVXC/Ok+C0a/fr77IQmSqDLll/
         CYzbuzmDm2+OHZbCu51GGzTwtcJlmdGqZBoB3k2WEu3E7ZfLHWuUtCNJffCM3vd4kytD
         h75APcWTq5GfIYQdcBd+ORv7euX6JU53veJR73OudYgqb1zpmyY7HT+CEEa8lHvky3JK
         fJexNvnmunr/Z6HMFnmRDDOSv28P2Z2y2MpCADz3aefkrY8AfuK+Xs1BHEI32rrYY59w
         h8W0yxvIVrBz8iW81xL7o3SRufT6ZPfs4ucen2GYWR3JpJayBC5s5tF1Gtm9L0tqOZTk
         Q9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11HABgG4cgofeXKrR7yB4qVxOwjvZW+qOCi2NPimHbk=;
        b=tMhZc1sbHKvH9LnTgdyZKuvgpqm72OdynQRldr5D9ghQvKmryQQB6iHXGX5mfEl4dU
         n41INmioAxgW0dkthROUYpM2el5RC7v2mWGgOLkIJYaj1houR6EJT0D4uyMO3pFRtlrU
         qdq1HmINQUKyy43DOGV8z/6dkA+UdtBAGnfimx75rw+lMUIFQ93Tz95TsmNx9EuBKlqm
         tWNbFxc4REak/+m0kgGWnalURy30suIfwEmWbOsXzUW2RmoPhY2L63Q2t4XyARyGYjcT
         UuTM9B6wqPRl4kwHXphIg2eLHKqjbiD9aQuIZZ2kGk++thtaPU3ucuE9c5tRkY0Mn0jC
         v7Jg==
X-Gm-Message-State: APjAAAXI3hjAHksWJAI2ejrw/yg/uduOVVlPzhtnxdaLZHz5su+Srdc5
        ibKQmLGYtg3SKj+01KPgsrYY/A==
X-Google-Smtp-Source: APXvYqxdgSH2LBsI1BNVKCGE4o19ADjNXKuKcQjC4hWiiauTRCCRnOEThsfn0v5Qac+1sVKsk2hU5Q==
X-Received: by 2002:a5d:81c3:: with SMTP id t3mr4392281iol.300.1572362026220;
        Tue, 29 Oct 2019 08:13:46 -0700 (PDT)
Received: from cisco ([2601:282:902:b340:7405:279a:1dff:4689])
        by smtp.gmail.com with ESMTPSA id t16sm1473529iol.12.2019.10.29.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:13:45 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:13:43 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029151343.GE32132@cisco>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Elena, Mike,

On Tue, Oct 29, 2019 at 11:25:12AM +0000, Reshetova, Elena wrote:
> > The patch below aims to allow applications to create mappins that have
> > pages visible only to the owning process. Such mappings could be used to
> > store secrets so that these secrets are not visible neither to other
> > processes nor to the kernel.
> 
> Hi Mike, 
> 
> I have actually been looking into the closely related problem for the past 
> couple of weeks (on and off). What is common here is the need for userspace
> to indicate to kernel that some pages contain secrets. And then there are
> actually a number of things that kernel can do to try to protect these secrets
> better. Unmap from direct map is one of them. Another thing is to map such
> pages as non-cached, which can help us to prevent or considerably restrict
> speculation on such pages. The initial proof of concept for marking pages as
> "UNCACHED" that I got from Dave Hansen was actually based on mlock2() 
> and a new flag for it for this purpose. Since then I have been thinking on what
> interface suits the use case better and actually selected going with new madvise() 
> flag instead because of all possible implications for fragmentation and performance. 
> My logic was that we better allocate the secret data explicitly (using mmap()) 
> to make sure that no other process data accidentally gets to suffer.
> Imagine I would allocate a buffer to hold a secret key, signal with mlock
>  to protect it and suddenly my other high throughput non-secret buffer 
> (which happened to live on the same page by chance) became very slow
>  and I don't even have an easy way (apart from mmap()ing it!) to guarantee
>  that it won't be affected.
> 
> So, I ended up towards smth like:
> 
>   secret_buffer =  mmap(NULL, PAGE_SIZE, ...)
>    madvise(secret_buffer, size, MADV_SECRET)
> 
> I have work in progress code here:
>  https://github.com/ereshetova/linux/commits/madvise
> 
> I haven't sent it for review, because it is not ready yet and I am now working
> on trying to add the page wiping functionality. Otherwise it would be useless
> to protect the page during the time it is used in userspace, but then allow it
> to get reused by a different process later after it has been released back and
> userspace was stupid enough not to wipe the contents (or was crashed on 
> purpose before it was able to wipe anything out). 

I was looking at this and thinking that wiping during do_exit() might
be a nice place, but I haven't tried anything yet.

> We have also had some discussions with Tycho that XPFO can be also
> applied selectively for such "SECRET" marked pages and I know that he has also
> did some initial prototyping on this, so I think it would be great to decide
> on userspace interface first and then see how we can assemble together all
> these features. 

Yep! Here's my tree with the direct un-mapping bits ported from XPFO:
https://github.com/tych0/linux/commits/madvise

As noted in one of the commit messages I think the bit math for page
prot flags needs a bit of work, but the test passes, so :)

In any case, I'll try to look at Mike's patches later today.

Cheers,

Tycho
