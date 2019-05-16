Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E720967
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEPOVp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 10:21:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54300 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfEPOVp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 10:21:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so3836488wml.4
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pBYZyFUkM5nWJomyVpE/m2x1DxoC1ycwj8/edxQgVk=;
        b=KHF71/U/SqXVY6AqApav+KABWAsZ5zGS1aK+fZExk5AnGg2DX3oWoPIMu75zcdBX1H
         M2MKiEY4psgSiSuZ7dB6cDXnU2KHVoWYuw7T+soxTb/C86gjUWtlaYPk3H39pmrLnCTG
         zpqnkaObgjLMKfzrlsjcKNWhX5+R6tlL8Kh0xnRJxYB1GZCd48Cj99mlVgVPW+N6xx6q
         NlXRPVfUyKexsEWlOSlDT37JHSmdVUmlX6K6+YP+an1woT3ekCx2Hwp1cm42rbJhOaFy
         2U6PyFDtzlRd0pbtQoEL854Ufb6rPHdkO6Ze0d0rkpvKuA3j3Op5wwjv2wtJXcWF+Yhb
         4PBA==
X-Gm-Message-State: APjAAAXJjZTm8WMegtTs1XFWupBorJ0twHWNTTcaf1jaHi2pDB2gCs/z
        iocbNNmPSmhPoFF1YnuaPFNPZw==
X-Google-Smtp-Source: APXvYqxXwoK109kD/ez3T5lP/j8A8AQ1AFMnns5SxEo7Ap1IuaYOUMPIMyPdhIllQencoKBO77rrOw==
X-Received: by 2002:a1c:2245:: with SMTP id i66mr12110548wmi.19.1558016504222;
        Thu, 16 May 2019 07:21:44 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j82sm7364200wmj.40.2019.05.16.07.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:21:43 -0700 (PDT)
Date:   Thu, 16 May 2019 16:21:42 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm/ksm, proc: introduce remote madvise
Message-ID: <20190516142142.qti3zfevuf67dedn@butterfly.localdomain>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516104412.GN16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516104412.GN16651@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Thu, May 16, 2019 at 12:44:12PM +0200, Michal Hocko wrote:
> On Thu 16-05-19 11:42:29, Oleksandr Natalenko wrote:
> [...]
> > * to mark all the eligible VMAs as mergeable, use:
> > 
> >    # echo merge > /proc/<pid>/madvise
> > 
> > * to unmerge all the VMAs, use:
> > 
> >    # echo unmerge > /proc/<pid>/madvise
> 
> Please do not open a new thread until a previous one reaches some
> conclusion. I have outlined some ways to go forward in
> http://lkml.kernel.org/r/20190515145151.GG16651@dhcp22.suse.cz.
> I haven't heard any feedback on that, yet you open a 3rd way in a
> different thread. This will not help to move on with the discussion.
> 
> Please follow up on that thread.

Sure, I will follow the thread once and if there are responses. Consider
this one to be an intermediate summary of current suggestions and also
an indication that it is better to have the code early for public eyes.

Thank you.

> -- 
> Michal Hocko
> SUSE Labs

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
