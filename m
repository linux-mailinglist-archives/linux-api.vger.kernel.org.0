Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77591E930
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEOHh1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 03:37:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37779 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfEOHh1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 May 2019 03:37:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so1392004wmo.2
        for <linux-api@vger.kernel.org>; Wed, 15 May 2019 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yj9XZyJEigbRqa/osUD7R/GjHPQqzoncrjwPfcCT3g0=;
        b=KogcGtET19bnHXbOwzX55J8yyeLE8kANrNBaV2lsEr0/xtyxcu9g/L9oeo/pfSe4Q5
         ZXVWcT31PHAO+4+tkeoM4X3iZT1J4YGwfFbN2OnVIdUZmyp8W2P7cHyPcxIONW+9RhPL
         W/5bxPrupuYjblO2szZjakOSQTm3wcvc9IVYvHM8lN96NADY3EDUqrVx5bwfkBtObfXl
         l4r5TpNiNIt5vIWrVOu74e2V8EpK93aYC/5GPSQpSEahhRA6t1Bsffi6yn0SYJCN2e9L
         wxPTMZGxc8GCrFZ6uPGwfDzL4cnjUErDq7ZZE8emKM1qimufVJvSw6qKzqD+gx+MeprB
         fmRQ==
X-Gm-Message-State: APjAAAVBbsB7h63Q+qzi5q2eeVEpGnJgTWqeLVesY2YDKHLuVvfEkf1D
        sAkxayU20aVYQr/Yx7uLr4SdjQ==
X-Google-Smtp-Source: APXvYqy5zHWEswH5rTU3ScYtOdXyuOYlmXMo5vxxHaeTCW2lRo0/VMy/6pvvXOi9nmKf0bD4sOWD2A==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr10334074wmj.87.1557905845417;
        Wed, 15 May 2019 00:37:25 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n15sm1056219wmi.42.2019.05.15.00.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 00:37:24 -0700 (PDT)
Date:   Wed, 15 May 2019 09:37:23 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515065311.GB16651@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Wed, May 15, 2019 at 08:53:11AM +0200, Michal Hocko wrote:
> On Wed 15-05-19 08:25:23, Oleksandr Natalenko wrote:
> [...]
> > > > Please make sure to describe a usecase that warrants adding a new
> > > > interface we have to maintain for ever.
> > 
> > I think of two major consumers of this interface:
> > 
> > 1) hosts, that run containers, especially similar ones and especially in
> > a trusted environment;
> > 
> > 2) heavy applications, that can be run in multiple instances, not
> > limited to opensource ones like Firefox, but also those that cannot be
> > modified.
> 
> This is way too generic. Please provide something more specific. Ideally
> with numbers. Why those usecases cannot use an existing interfaces.
> Remember you are trying to add a new user interface which we will have
> to maintain for ever.

For my current setup with 2 Firefox instances I get 100 to 200 MiB saved
for the second instance depending on the amount of tabs.

1 FF instance with 15 tabs:

$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
410

2 FF instances, second one has 12 tabs (all the tabs are different):

$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
592

At the very moment I do not have specific numbers for containerised
workload, but those should be similar in case the containers share
similar/same runtime (like multiple Node.js containers etc).

Answering your question regarding using existing interfaces, since
there's only one, madvise(2), this requires modifying all the
applications one wants to de-duplicate. In case of containers with
arbitrary content or in case of binary-only apps this is pretty hard if
not impossible to do properly.

> I will try to comment on the interface itself later. But I have to say
> that I am not impressed. Abusing sysfs for per process features is quite
> gross to be honest.

Sure, please do.

Thanks for your time and inputs.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
