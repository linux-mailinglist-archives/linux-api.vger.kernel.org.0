Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F12FEB7F
	for <lists+linux-api@lfdr.de>; Thu, 21 Jan 2021 14:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbhAUNVj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Jan 2021 08:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbhAUNUE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Jan 2021 08:20:04 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60960C061575
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:20 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n22so1406835qtv.10
        for <linux-api@vger.kernel.org>; Thu, 21 Jan 2021 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zruIQedjwNcDhDYNEYrrXFR6YFTuvFQowbaXONNBZzQ=;
        b=auEArelE69t+FGAy3A0cQlrQNM8iE4wySncCyMEzHElhKgOjhVQN/ZW2PeVmojNZgA
         uC2vhrlm5XJp5UDg9ky+/Xndsf7D8V2HO0zuIQBwazFcPBwhaRNDbdHGy4miwBHsY/jz
         R3bLryjDG5pSgjVRpkNBoWI4PxyiLPjXj7Vy7H+RcO0mz3OO5xdti0J8DBXQDwlYMl2X
         2kXd4Dg3+Yf4CG+VpM8KKgRInbiqAljQwZv/6O44r3uWBhjaA7cB1rEDB/PSue8fYqRl
         4dO6ZmVm0Yg/EvzmkAQQlMIsp29cw2KpfkHZ10Dd66KUZaK6BW2h7zSRN1dQGFfStiYL
         qczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zruIQedjwNcDhDYNEYrrXFR6YFTuvFQowbaXONNBZzQ=;
        b=NeQJA6+e6VPmfd30EzyhUbqJuJ+WQnPxdNUVvXPy/Rr/FQEgIvlXTKaAf6zCinENbq
         ZcavgZKH4Ylj5JM/Oz+vKSmYg5790hijgVgxpIea6tA4Ecjym6HbbOpQc8qWqVkHFnGJ
         Ot6HsrTh7VFrnv/kt0nEQkqzCgOG3pe+PlW3la1ydXH0dk6mYbz9e8sJ5f7ed72nOpas
         I6Im06meBw38OpJIX75p5GLF/JQueo4DsK2VZr8iS9GM12adGfJcPXdaT3FKzKldl/zf
         jOUYC8Y1lxHf5zoqus9MfIEal6SvH9/qxLyDZ+19ym+2+LRnnUi/a5vRrUpJtUhwvS/X
         Pnyg==
X-Gm-Message-State: AOAM530cSU6q/VxLCnVtPY06rtZWeQxsDhnHggAovjgNTeIYhIGl/6R0
        2H5SQYTvDePh5WC6K5SMjkNh01ajB3Q=
X-Google-Smtp-Source: ABdhPJzFoRrCNu6UqrEYfSA9a/pnawzMv2aw7MtKk+jQYTz8jXHoLSFgsHYsaeUML4+BBYgjYB7eJpdq+8I=
Sender: "glider via sendgmr" <glider@glider.muc.corp.google.com>
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:9ff])
 (user=glider job=sendgmr) by 2002:a05:6214:14ae:: with SMTP id
 bo14mr14422919qvb.16.1611235159490; Thu, 21 Jan 2021 05:19:19 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:19:12 +0100
Message-Id: <20210121131915.1331302-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 0/3] Add error_report_end tracepoint to KFENCE and KASAN
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, glider@google.com
Cc:     elver@google.com, andreyknvl@google.com, dvyukov@google.com,
        mingo@redhat.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org,
        linux-api@vger.kernel.org, vbabka@suse.cz,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchset adds a tracepoint, error_repor_end, that is to be used by
KFENCE, KASAN, and potentially other bug detection tools, when they
print an error report.
One of the possible use cases is userspace collection of kernel error
reports: interested parties can subscribe to the tracing event via
tracefs, and get notified when an error report occurs.

v3:
 - dropped the sysfs interface for log collection
 - dropped error_report_start tracepoint

v2:
 - added ABI documentation for /sys/kernel/error_report/
 - changed error_report_start and error_report end tracepoints to take
   a fixed set of values for the error detector


Alexander Potapenko (3):
  tracing: add error_report_end trace point
  kfence: use error_report_end tracepoint
  kasan: use error_report_end tracepoint

 include/trace/events/error_report.h | 74 +++++++++++++++++++++++++++++
 kernel/trace/Makefile               |  1 +
 kernel/trace/error_report-traces.c  | 12 +++++
 mm/kasan/report.c                   |  8 ++--
 mm/kfence/report.c                  |  2 +
 5 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/error_report.h
 create mode 100644 kernel/trace/error_report-traces.c

-- 
2.30.0.296.g2bfb1c46d8-goog

