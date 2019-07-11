Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1583065F51
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2019 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfGKSHb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 14:07:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKSHa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jul 2019 14:07:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so3431298plb.5
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2019 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFqqVAf53kQZdQpKzWHw6YV0GKjGRqkuwN0W084Idiw=;
        b=tF3TLrAgMwyyskndvYBbdeyeiTdA3ax3J7vfMGNXEegyPwcKqVxi0vW4QF8Sbo9L5W
         6OJUTIJAIWTZ6kDHn9Rv2qLS2xtqXEkdbqacOfgHYFg6HZzoRJ/Ai5gJZYJ5hAWMIZ1i
         UykxeqaETOYUXDlhn2iVJspR45SoeMH5gfP7RQBZC0w1ekRo0mYMhWilnnztwDL99w0v
         2SQcmkV3JGGe7XtnqSV6bNjtH65hfzDSJfN5lILS8DFbRrsh5tasseTAZgiZmLzPNgyg
         lZOSsTWjhmHGGU223CWsarbZthwmuT7ikTEsPom1WpjgEWZqxirlJhjcCi7DUoxUnQv9
         XTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFqqVAf53kQZdQpKzWHw6YV0GKjGRqkuwN0W084Idiw=;
        b=Aq2VArWgAbWpXBnBHmEd0xWB1fphljnKRwc8aE6oO/oEu7v1MiIqO6qh2CoXYk1Sub
         u3c3vzVJ4RBKlQbS1mPgmLp5DsJqN9ukG0wnkZbV29OlNJTQ/dmcLPFEVhJ6Po22TKAL
         DIChDCHqkayJkzGWE8iTossxYgFz2+ByxVRV5eUuGr48fzZgc1ms37uG9ibZ6q1vgEsE
         FfI/5gYjNATbLZGp0juWwD5263Dk8ubdwOtyodjswvxH0lmfOrY1Tff8OHgdqHH6NS1g
         YAFEsMTGmb4eWtU8g7nRew6SIOVvgPoMLtfZv3o8wmI0cJaYc+xBB/f8ykkYkRqSiS9V
         JMcQ==
X-Gm-Message-State: APjAAAWPbzTswOsnHR1Pg/GBilHdDiCgt9nbnCZZ9DnQmiLwAyWoCuQN
        BMRm27iN22XPpP8uK2kobT8=
X-Google-Smtp-Source: APXvYqzMAQG40OUqLYdym3Kco+SvImeO5ZcrWpZB4aqsTh7miN748rzlQ4W0jLflNC0KF2SfAxfUFg==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr6305306plb.55.1562868450408;
        Thu, 11 Jul 2019 11:07:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5385])
        by smtp.gmail.com with ESMTPSA id w2sm2686882pgc.32.2019.07.11.11.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 11:07:29 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:07:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/4] mm: account nr_isolated_xxx in
 [isolate|putback]_lru_page
Message-ID: <20190711180727.GC20341@cmpxchg.org>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711012528.176050-4-minchan@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 11, 2019 at 10:25:27AM +0900, Minchan Kim wrote:
> The isolate counting is pecpu counter so it would be not huge gain
> to work them by batch. Rather than complicating to make them batch,
> let's make it more stright-foward via adding the counting logic
> into [isolate|putback]_lru_page API.
> 
> * v1
>  * fix accounting bug - Hillf
> 
> Link: http://lkml.kernel.org/r/20190531165927.GA20067@cmpxchg.org
> Acked-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

This is tricky to review, but fwiw it looks correct to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
