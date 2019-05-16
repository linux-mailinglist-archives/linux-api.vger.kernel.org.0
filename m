Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317D120CFB
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfEPQ3t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 12:29:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36638 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfEPQ3t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 12:29:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so4129008wmj.1
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 09:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmJ3oGbhkIfE+oGMXz0i/1fqw7BH4scbuPzlcTLdX0o=;
        b=o+aOkTF0KuffJ6yXFYmcLAuMKISkWyHX9UWt+V3ohnnZ0R9V9+gvKxw3rgPxodS1xs
         4moQI8O1bclDv+xpJntCuk/7doKXfz0xMIt6WUkL0OJr6GZviGDt8qwqkThg49tlpGtP
         5yW5MiunwvqRLfnlri1jsWeWJPbgvB8TiiG6JloqT8rz5hw2+QEXJ2e80qFdmFpgKj2W
         rp7+phZUcbVLjw1wDoE/qo1KtAI5HxltbG9+mEOCJKmX+n1t++OQqO0Q28ke5l3XD/P3
         FMlz3HPux/eEhpJ5+UpfHn42Bc3tsfztrIXzQWkI/VzNHpEdlhoZBY4Rjm855MGV9Fie
         +xCw==
X-Gm-Message-State: APjAAAXe27hKFyw7xIKSNBQEHufbnkDnt9TSEjC/Jp8Q26g/h7xqOXVH
        FXfijOx2J7qBh8H4Ap4lyRkj4g9sUSJC
X-Google-Smtp-Source: APXvYqw4xzsO/ZHDRK8RT2D9NZpnGvFVdO15DLWHiBOzYw0vUAqtOT7NkS6GGg4mfAYLcWMR8bMLaA==
X-Received: by 2002:a1c:e714:: with SMTP id e20mr18848944wmh.143.1558024187943;
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id l8sm7695747wrw.56.2019.05.16.09.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:29:47 -0700 (PDT)
Date:   Thu, 16 May 2019 17:29:46 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Message-ID: <20190516162946.zwzhxkft342b25pd@atomlin.usersys.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 2019-05-16 12:00 +0200, Jann Horn wrote:
> On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
> <oleksandr@redhat.com> wrote:
[ ... ]
> > +       }
> > +
> > +       down_write(&mm->mmap_sem);
> 
> Should a check for mmget_still_valid(mm) be inserted here? See commit
> 04f5866e41fb70690e28397487d8bd8eea7d712a.

Yes - I'd say this is required here.

Thanks,

-- 
Aaron Tomlin
