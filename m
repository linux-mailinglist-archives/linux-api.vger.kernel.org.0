Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE0BE5D5
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 21:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfIYTno (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 15:43:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbfIYTno (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 15:43:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDDCF-0000Lt-Lv; Wed, 25 Sep 2019 19:43:32 +0000
Date:   Wed, 25 Sep 2019 20:43:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925194331.GL26530@ZenIV.linux.org.uk>
References: <20190925165915.8135-1-cyphar@cyphar.com>
 <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin>
 <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
 <20190925180412.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 11:13:18AM -0700, Linus Torvalds wrote:
> On Wed, Sep 25, 2019 at 11:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > IMO it's better to lift reading the first word out of the loop, like this:
> >   ...
> > Do you see any problems with that variant?
> 
> That looks fine to me too.
> 
> It's a bit harder for humans to read because of how it reads the word
> from user space one iteration early, but from a code generation
> standpoint it probably is better.
> 
> So slightly subtler source code, and imho harder to read, but it looks
> correct to me.

FWIW, I would probably add a kernel-space analogue of that thing at the
same time - check that an area is all-zeroes is not all that rare.
In fact, most of the callers of memchr_inv() are exactly that:

arch/x86/kernel/fpu/xstate.c:492:       if (memchr_inv(hdr->reserved, 0, sizeof(hdr->reserved)))
crypto/async_tx/async_xor.c:225:        return !memchr_inv(page_address(p) + offset, 0, len);
crypto/dh_helper.c:109: if (memchr_inv(params->p, 0, params->p_size) == NULL)
crypto/testmgr.c:446:           memchr_inv(&divs[i], 0, (count - i) * sizeof(divs[0])) == NULL;
crypto/testmgr.c:470:           if (memchr_inv(cfg->dst_divs, 0, sizeof(cfg->dst_divs))) 
crypto/testmgr.c:3802:  if (memchr_inv(outbuf_dec, 0, out_len - m_size) ||
drivers/block/rbd.c:3138:               if (memchr_inv(page_address(bv.bv_page) + bv.bv_offset, 0, 
drivers/gpu/drm/drm_dp_mst_topology.c:1808:     if (memchr_inv(guid, 0, 16))
drivers/gpu/drm/drm_edid.c:1359:        if (memchr_inv(in_edid, 0, length))
drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:238:       if (memchr_inv(ptr, 0, dmabuf->size)) {
drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:284:       if (memchr_inv(ptr, 0, PAGE_SIZE)) {
drivers/infiniband/core/uverbs_cmd.c:2741:              if (memchr_inv(kern_spec_filter +
drivers/infiniband/core/uverbs_ioctl.c:143:     return !memchr_inv((const void *)&uattr->data + len,
drivers/infiniband/hw/efa/efa_verbs.c:127:      !memchr_inv(reserved, 0, sizeof(reserved))
drivers/infiniband/hw/mlx4/main.c:1330: memchr_inv((void *)&filter.field  +\
drivers/infiniband/hw/mlx4/qp.c:728:    if (memchr_inv(ucmd.reserved, 0, sizeof(ucmd.reserved)))
drivers/infiniband/hw/mlx5/main.c:2516: !(memchr_inv(MLX5_ADDR_OF(fte_match_param, match_criteria, headers), \
drivers/infiniband/hw/mlx5/main.c:2621: memchr_inv((void *)&filter.field  +\ 
drivers/infiniband/hw/mlx5/qp.c:3921:               memchr_inv(&ucmd.reserved, 0, sizeof(ucmd.reserved)) ||
drivers/infiniband/hw/mlx5/qp.c:3922:               memchr_inv(&ucmd.burst_info.reserved, 0,
drivers/md/dm-integrity.c:3844:                 if (memchr_inv(ic->sb, 0, SB_SECTORS << SECTOR_SHIFT)) {
drivers/mtd/nand/raw/qcom_nandc.c:1548: if (memchr_inv(data_buf, 0xff, data_len)) {
drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c:179: if (memchr_inv(&enc_opts.mask->data, 0, sizeof(enc_opts.mask->data)) &&
drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_geneve.c:240: if (!memchr_inv(option_key->opt_data, 0, option_key->length * 4)) {
drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:113:         if (memchr_inv(misc, 0, MLX5_ST_SZ_BYTES(fte_match_set_misc)))
drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c:374:   if (!memchr_inv(mask_value, 0, len)) /* If mask is zero */
drivers/net/geneve.c:1243:               memchr_inv(&info->key.u, 0, sizeof(info->key.u)));
drivers/nvme/host/core.c:1619:          memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) ||
drivers/nvme/host/core.c:1620:          memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
drivers/nvme/host/core.c:2884:  if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
drivers/nvme/host/core.c:2887:  if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
drivers/nvme/host/core.c:2962:              !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
drivers/nvme/host/core.c:2966:          if (!memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
drivers/nvme/host/core.c:2970:          if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
drivers/nvme/target/admin-cmd.c:544:    if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
drivers/nvme/target/admin-cmd.c:551:    if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
drivers/target/target_core_iblock.c:425:        not_zero = memchr_inv(buf, 0x00, cmd->data_length);
fs/btrfs/ioctl.c:4586:          if (memchr_inv(loi->reserved, 0, sizeof(loi->reserved))) {
fs/cramfs/inode.c:351:  return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
fs/ext4/ioctl.c:649:    if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
fs/ext4/ioctl.c:650:        memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
fs/ext4/ioctl.c:652:        memchr_inv(head.fmh_keys[1].fmr_reserved, 0,
fs/gfs2/lock_dlm.c:485: return !memchr_inv(lvb + JID_BITMAP_OFFSET, 0,
fs/ubifs/auth.c:565:    return !memchr_inv(hmac, 0, c->hmac_desc_len);
fs/xfs/scrub/agheader.c:276:            if (memchr_inv(&sb->sb_features_compat, 0,
fs/xfs/scrub/agheader.c:332:    if (memchr_inv(sb + 1, 0,
fs/xfs/scrub/scrub.c:371:       if (memchr_inv(sm->sm_reserved, 0, sizeof(sm->sm_reserved)))
fs/xfs/xfs_icache.h:95: if (memchr_inv(&src->pad32, 0, sizeof(src->pad32)) ||
fs/xfs/xfs_icache.h:96:     memchr_inv(src->pad64, 0, sizeof(src->pad64)))
fs/xfs/xfs_ioctl.c:846:     memchr_inv(hdr->reserved, 0, sizeof(hdr->reserved)))
fs/xfs/xfs_ioctl.c:1866:        if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
fs/xfs/xfs_ioctl.c:1867:            memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
fs/xfs/xfs_ioctl.c:1869:            memchr_inv(head.fmh_keys[1].fmr_reserved, 0,
include/rdma/ib_verbs.h:2782:   ret = !memchr_inv(buf, 0, len);
kernel/bpf/syscall.c:461:       memchr_inv((void *) &attr->CMD##_LAST_FIELD + \
mm/vmstat.c:1827:               if (memchr_inv(p->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
mm/vmstat.c:1831:               if (memchr_inv(p->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
net/bpf/test_run.c:196: return !memchr_inv((u8 *)buf + from, 0, to - from);
net/sched/act_ct.c:317: if (!memchr_inv(labels_m, 0, labels_sz))
net/sched/act_ct.c:762: if (mask && !memchr_inv(mask, 0, len))
net/sched/cls_flower.c:1322:    memchr_inv(((char *)mask) + FL_KEY_MEMBER_OFFSET(member),               \
net/sched/cls_flower.c:1967:    if (!memchr_inv(mask, 0, len))
net/sched/cls_flower.c:2006:    if (!memchr_inv(mpls_mask, 0, sizeof(*mpls_mask)))
net/sched/cls_flower.c:2058:    if (!memchr_inv(vlan_mask, 0, sizeof(*vlan_mask)))
net/sched/cls_flower.c:2092:    if (!memchr_inv(&flags_mask, 0, sizeof(flags_mask)))
security/keys/dh.c:257:         if (memchr_inv(kdfcopy->__spare, 0, sizeof(kdfcopy->__spare))) {

- 66 out of 90.  So it smell like we might want something like
bool all_zeroes(const void *p, size_t)
somewhere in lib/string.c, with comment regarding keeping it in sync
with __user variant.

Another thing is that for s390 we almost certainly want something better
than word-by-word.  IIRC, word-sized userland accesses really hurt there.
It's nowhere near as critical as with strncpy_from_user(), but with the
same underlying issue.
