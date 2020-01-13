Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1C139A25
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 20:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMT1l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 14:27:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38966 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgAMT1l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 14:27:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so9418017oib.6
        for <linux-api@vger.kernel.org>; Mon, 13 Jan 2020 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kn52d9L0ca52gNc3n8O9DhLTFY/ai8fCyuw7ZaovG/c=;
        b=iTp9iLl+2sajghi8PUP9cyUrByJ/eObxBtaFyhGFG1S3lFR2+haIyEe2ZtVDpaV2E9
         jxfk7xoaiZ5NLeT/BoK4Sn4m+qduPaBEfQSJCF3vJBXVjZiNZXv1c+Jq864ttV+KMRpC
         rjzoboLEf4yU93/fqZThB9UCpAqNtbAGJizja5zau4OBqyO16fC2IMLSu1sgpuwgCjUx
         wmu5FrXUv/yO+C/9+Xvigng1EradwqZY8mhxoxA+dsjLh9DeN1Ff0pVGdLIGv8X7OzSb
         sr3YGzhAp1G5f1RMCX1bL3QHusPQsxfUw+yugNDtRg5WGLEFtMvKG4ZVygDNAweTfbY8
         S6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kn52d9L0ca52gNc3n8O9DhLTFY/ai8fCyuw7ZaovG/c=;
        b=WnwI+8UMbYLkIZYCHphseLpQbE3I+lZR049RdYaKgc/RAxwwxnk35xGirfDjSMCtzJ
         OAFj4K93/Oj9x7KADU+VUKudbUwQP7gcdF+G9WMBr1SzaGoQUgVZXVWhjGbJF8SneQRT
         G7NSzSpyFvyyOphU9mP/vN4M5ugNpHFWjjmRQ2ngfoJEvb0rOjEh7hq9W7kuuDQE0qe5
         yXNcUcXYm2l2nws/0my58GCLGCH0qJFWIgUHvewsV4RZ+qdjn6Nhm18JEYXLz5Np1MTY
         rKlHyIwnhpCtIbbxGVUbeDDj9ChF/mbc00yprs75GziniB/6/xW5T8NncSlXvDFyIfyg
         enUw==
X-Gm-Message-State: APjAAAVVXuNHRCJcXNpbfI1A5gJHnu+FFK7TEidHmrt9ZQLWjKW3Gccb
        jJ+87Timc6PUlx3xJAMDTdByS90Sugg14rVr1RGCUZ0b
X-Google-Smtp-Source: APXvYqzUy5kz5MCFujOKQJTl7DBbQ2xcSsMVUThyL8uDRUzqtcvXFWS1FCfAHyMFkkflER1Iyz9ACpk9tHPXu+m5Q2A=
X-Received: by 2002:aca:f20b:: with SMTP id q11mr13344801oih.78.1578943660130;
 Mon, 13 Jan 2020 11:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20200110213433.94739-1-minchan@kernel.org> <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com> <20200113104256.5ujbplyec2sk4onn@wittgenstein>
 <20200113184408.GD110363@google.com> <20200113191046.2tidyvc544zvchek@wittgenstein>
In-Reply-To: <20200113191046.2tidyvc544zvchek@wittgenstein>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Jan 2020 11:27:03 -0800
Message-ID: <CAKOZuev5k3EquMd-6VbvruahjjtxQzRhUVo2ttgVyk+yYz9aOA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 13, 2020 at 11:10 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This does not
> affect the permission checking you're performing here.

Pidfds-as-capabilities sounds like a good change. Can you clarify what
you mean here though? Do you mean that in order to perform some
process-directed operation X on process Y, the pidfd passed to X must
have been opened with PIDFD_CAP_X *and* the process *using* the pidfds
must be able to perform operation X on process Y? Or do pidfds in this
model "carry" permissions in the same way that an ordinary file
descriptor "carries" the ability to write to a file if it was opened
with O_WRONLY even if the FD is passed to a process that couldn't
otherwise write to that file? Right now, pidfds are identity-only and
always rely on the caller's permissions. I like the capability bit
model because it makes pidfds more consistent with other file
descriptors and enabled delegation of capabilities across the system.
